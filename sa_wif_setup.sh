#!/bin/bash

export PROJECT_ID="devops-projects-426703"
export PROJECT_NUMBER="664946097791"
export STATE_BUCKET="terraform-state-aitdevops-env"

# Check if the bucket already exists before trying to create it
if ! gsutil ls -b gs://$STATE_BUCKET/ &>/dev/null; then
  echo "Creating bucket $STATE_BUCKET..."
  gcloud storage buckets create gs://$STATE_BUCKET --project=$PROJECT_ID --default-storage-class=STANDARD --location=EUROPE-WEST1 --uniform-bucket-level-access || { echo "Failed to create bucket $STATE_BUCKET"; exit 1; }
else
  echo "Bucket $STATE_BUCKET already exists."
fi

# Check if the workload identity pool already exists
if ! gcloud iam workload-identity-pools describe aitdevops-pool --project=$PROJECT_ID --location=global &>/dev/null; then
  echo "Creating Workload Identity Pool 'aitdevops-pool'..."
  gcloud iam workload-identity-pools create aitdevops-pool \
      --project=$PROJECT_ID \
      --location="global" \
      --description="AIT DevOps Pool" \
      --display-name="AIT DevOps Pool" || { echo "Failed to create Workload Identity Pool 'aitdevops-pool'"; exit 1; }
else
  echo "Workload Identity Pool 'aitdevops-pool' already exists."
fi

# Create the workload identity provider if it doesn't exist
if ! gcloud iam workload-identity-pools providers describe "aitdevops-provider" --project="${PROJECT_ID}" --location="global" --workload-identity-pool="aitdevops-pool" &>/dev/null; then
  echo "Creating Workload Identity Provider 'aitdevops-provider'..."
  gcloud iam workload-identity-pools providers create-oidc "aitdevops-provider" \
    --project="${PROJECT_ID}" \
    --location="global" \
    --workload-identity-pool="aitdevops-pool" \
    --display-name="AIT DevOps GitHub Provider" \
    --attribute-mapping="google.subject=assertion.sub,attribute.repository=assertion.repository,attribute.ref=assertion.ref" \
    --issuer-uri="https://token.actions.githubusercontent.com" || { echo "Failed to create Workload Identity Provider 'aitdevops-provider'"; exit 1; }
else
  echo "Workload Identity Provider 'aitdevops-provider' already exists."
fi

# Check if service accounts already exist before creating them
if ! gcloud iam service-accounts describe aitdevops-tf-plan@${PROJECT_ID}.iam.gserviceaccount.com &>/dev/null; then
  echo "Creating Service Account 'aitdevops-tf-plan'..."
  gcloud iam service-accounts create aitdevops-tf-plan \
      --project=$PROJECT_ID \
      --description="AIT DevOps Terraform Planner" \
      --display-name="AIT DevOps Terraform Planner" || { echo "Failed to create Service Account 'aitdevops-tf-plan'"; exit 1; }
else
  echo "Service Account 'aitdevops-tf-plan' already exists."
fi

if ! gcloud iam service-accounts describe aitdevops-tf-apply@${PROJECT_ID}.iam.gserviceaccount.com &>/dev/null; then
  echo "Creating Service Account 'aitdevops-tf-apply'..."
  gcloud iam service-accounts create aitdevops-tf-apply \
      --project=$PROJECT_ID \
      --description="AIT DevOps Terraform Applier" \
      --display-name="AIT DevOps Terraform Applier" || { echo "Failed to create Service Account 'aitdevops-tf-apply'"; exit 1; }
else
  echo "Service Account 'aitdevops-tf-apply' already exists."
fi

# Assign required IAM roles to the service accounts
roles=(
    "roles/compute.viewer"
    "roles/compute.securityAdmin"
    "roles/container.admin"
    "roles/container.clusterAdmin"
    "roles/container.developer"
    "roles/container.serviceAgent"
    "roles/iam.serviceAccountAdmin"
    "roles/iam.serviceAccountUser"
    "roles/resourcemanager.projectIamAdmin"
    "roles/artifactregistry.admin"
    "roles/dns.admin"
    "roles/artifactregistry.reader"
    "roles/cloudsql.admin"
    "roles/cloudsql.client"
    "roles/iam.serviceAccountUser"
    "roles/cloudfunctions.viewer"
    "roles/cloudfunctions.developer"
)

for role in "${roles[@]}"; do
  echo "Assigning role $role to aitdevops-tf-apply service account..."
  gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member=serviceAccount:aitdevops-tf-apply@${PROJECT_ID}.iam.gserviceaccount.com \
    --role="$role" || { echo "Failed to assign role $role"; exit 1; }
done

# Update IAM policy bindings for the bucket
echo "Assigning roles for bucket $STATE_BUCKET..."
gcloud storage buckets add-iam-policy-binding gs://${STATE_BUCKET} \
  --member=serviceAccount:aitdevops-tf-plan@${PROJECT_ID}.iam.gserviceaccount.com \
  --role=roles/storage.objectAdmin || { echo "Failed to assign storage.objectAdmin role to aitdevops-tf-plan"; exit 1; }

gcloud storage buckets add-iam-policy-binding gs://${STATE_BUCKET} \
  --member=serviceAccount:aitdevops-tf-apply@${PROJECT_ID}.iam.gserviceaccount.com \
  --role=roles/storage.objectAdmin || { echo "Failed to assign storage.objectAdmin role to aitdevops-tf-apply"; exit 1; }

# Update IAM policy bindings for the project
echo "Assigning serviceAccountAdmin role to aitdevops-tf-apply..."
gcloud projects add-iam-policy-binding ${PROJECT_ID} \
 --member=serviceAccount:aitdevops-tf-apply@${PROJECT_ID}.iam.gserviceaccount.com \
 --role=roles/iam.serviceAccountAdmin || { echo "Failed to assign iam.serviceAccountAdmin role to aitdevops-tf-apply"; exit 1; }

# Grant Token Creator role on the service account itself (for impersonation)
echo "Granting Token Creator role to aitdevops-tf-apply service account..."
gcloud iam service-accounts add-iam-policy-binding "aitdevops-tf-apply@${PROJECT_ID}.iam.gserviceaccount.com" \
  --project="${PROJECT_ID}" \
  --role="roles/iam.serviceAccountTokenCreator" \
  --member="serviceAccount:aitdevops-tf-apply@${PROJECT_ID}.iam.gserviceaccount.com" || { echo "Failed to grant Token Creator role"; exit 1; }

# Add workload identity user role to the service accounts
echo "Binding workload identity roles..."
gcloud iam service-accounts add-iam-policy-binding "aitdevops-tf-plan@${PROJECT_ID}.iam.gserviceaccount.com" \
  --project="${PROJECT_ID}" \
  --role="roles/iam.workloadIdentityUser" \
  --member="principalSet://iam.googleapis.com/projects/${PROJECT_NUMBER}/locations/global/workloadIdentityPools/aitdevops-pool/attribute.repository/aitdevops/repo" || { echo "Failed to bind workload identity user role to aitdevops-tf-plan"; exit 1; }

gcloud iam service-accounts add-iam-policy-binding "aitdevops-tf-apply@${PROJECT_ID}.iam.gserviceaccount.com" \
  --project="${PROJECT_ID}" \
  --role="roles/iam.workloadIdentityUser" \
  --member="principalSet://iam.googleapis.com/projects/${PROJECT_NUMBER}/locations/global/workloadIdentityPools/aitdevops-pool/attribute.ref/refs/heads/main" || { echo "Failed to bind workload identity user role to aitdevops-tf-apply"; exit 1; }

echo "Script execution completed successfully."
