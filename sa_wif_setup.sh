#!/bin/bash

export PROJECT_ID="devops-projects-426703"
export PROJECT_NUMBER="664946097791"
export STATE_BUCKET="terraform-state-aitdevops-env"

# Check if the bucket already exists before trying to create it
if ! gsutil ls -b gs://$STATE_BUCKET/; then
  gcloud storage buckets create gs://$STATE_BUCKET --project=$PROJECT_ID --default-storage-class=STANDARD --location=EUROPE-WEST1 --uniform-bucket-level-access
fi

# Check if the workload identity pool already exists
if ! gcloud iam workload-identity-pools describe aitdevops-pool --project=$PROJECT_ID --location=global; then
  gcloud iam workload-identity-pools create aitdevops-pool \
      --project=$PROJECT_ID \
      --location="global" \
      --description="AIT DevOps Pool" \
      --display-name="AIT DevOps Pool"
fi

# Create the workload identity provider if it doesn't exist
gcloud iam workload-identity-pools providers describe "aitdevops-pool" --project="${PROJECT_ID}" --location="global" --workload-identity-pool="aitdevops-pool" || \
gcloud iam workload-identity-pools providers create-oidc "aitdevops-pool" \
  --project="${PROJECT_ID}" \
  --location="global" \
  --workload-identity-pool="aitdevops-pool" \
  --display-name="AIT DevOps GitHub Provider" \
  --attribute-mapping="google.subject=assertion.sub,attribute.repository=assertion.repository,attribute.ref=assertion.ref" \
  --issuer-uri="https://token.actions.githubusercontent.com"

# Check if service accounts already exist before creating them
if ! gcloud iam service-accounts describe aitdevops-tf-plan@${PROJECT_ID}.iam.gserviceaccount.com; then
  gcloud iam service-accounts create aitdevops-tf-plan \
      --project=$PROJECT_ID \
      --description="AIT DevOps Terraform Planner" \
      --display-name="AIT DevOps Terraform Planner"
fi

if ! gcloud iam service-accounts describe aitdevops-tf-apply@${PROJECT_ID}.iam.gserviceaccount.com; then
  gcloud iam service-accounts create aitdevops-tf-apply \
      --project=$PROJECT_ID \
      --description="AIT DevOps Terraform Applier" \
      --display-name="AIT DevOps Terraform Applier"
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
)

for role in "${roles[@]}"; do
  gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member=serviceAccount:aitdevops-tf-apply@${PROJECT_ID}.iam.gserviceaccount.com \
    --role="$role"
done

# Update IAM policy bindings for the bucket
gcloud storage buckets add-iam-policy-binding gs://${STATE_BUCKET} \
  --member=serviceAccount:aitdevops-tf-plan@${PROJECT_ID}.iam.gserviceaccount.com \
  --role=roles/storage.objectAdmin

gcloud storage buckets add-iam-policy-binding gs://${STATE_BUCKET} \
  --member=serviceAccount:aitdevops-tf-apply@${PROJECT_ID}.iam.gserviceaccount.com \
  --role=roles/storage.objectAdmin

# Update IAM policy bindings for the project
gcloud projects add-iam-policy-binding ${PROJECT_ID} \
 --member=serviceAccount:aitdevops-tf-apply@${PROJECT_ID}.iam.gserviceaccount.com \
 --role=roles/iam.serviceAccountAdmin

gcloud iam service-accounts add-iam-policy-binding "aitdevops-tf-plan@${PROJECT_ID}.iam.gserviceaccount.com" \
  --project="${PROJECT_ID}" \
  --role="roles/iam.workloadIdentityUser" \
  --member="principalSet://iam.googleapis.com/projects/${PROJECT_NUMBER}/locations/global/workloadIdentityPools/aitdevops-pool/attribute.repository/aitdevops/repo"

gcloud iam service-accounts add-iam-policy-binding "aitdevops-tf-apply@${PROJECT_ID}.iam.gserviceaccount.com" \
  --project="${PROJECT_ID}" \
  --role="roles/iam.workloadIdentityUser" \
  --member="principalSet://iam.googleapis.com/projects/${PROJECT_NUMBER}/locations/global/workloadIdentityPools/aitdevops-pool/attribute.ref/refs/heads/main"
