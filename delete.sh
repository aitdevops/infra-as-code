#!/bin/bash

# Set variables
PROJECT_ID="devops-projects-426703"
SERVICE_ACCOUNT_NAME="github-actions"
WORKLOAD_IDENTITY_POOL="github-actions-pool"
WORKLOAD_IDENTITY_PROVIDER="github-actions-provider"

# Function to delete a Workload Identity Provider if it exists
delete_workload_identity_provider() {
  if gcloud iam workload-identity-pools providers describe $WORKLOAD_IDENTITY_PROVIDER \
    --project=$PROJECT_ID \
    --location="global" \
    --workload-identity-pool=$WORKLOAD_IDENTITY_POOL &>/dev/null; then
    echo "Deleting Workload Identity Provider: $WORKLOAD_IDENTITY_PROVIDER"
    gcloud iam workload-identity-pools providers delete $WORKLOAD_IDENTITY_PROVIDER \
      --project=$PROJECT_ID \
      --location="global" \
      --workload-identity-pool=$WORKLOAD_IDENTITY_POOL --quiet
  else
    echo "Workload Identity Provider $WORKLOAD_IDENTITY_PROVIDER does not exist or has already been deleted."
  fi
}

# Function to delete a Workload Identity Pool if it exists
delete_workload_identity_pool() {
  if gcloud iam workload-identity-pools describe $WORKLOAD_IDENTITY_POOL \
    --project=$PROJECT_ID \
    --location="global" &>/dev/null; then
    echo "Deleting Workload Identity Pool: $WORKLOAD_IDENTITY_POOL"
    gcloud iam workload-identity-pools delete $WORKLOAD_IDENTITY_POOL \
      --project=$PROJECT_ID \
      --location="global" --quiet
  else
    echo "Workload Identity Pool $WORKLOAD_IDENTITY_POOL does not exist or has already been deleted."
  fi
}

# Function to remove IAM policy bindings if they exist
remove_iam_policy_bindings() {
  echo "Removing IAM policy bindings for Service Account: $SERVICE_ACCOUNT_NAME"
  ROLES=(
    "roles/iam.serviceAccountTokenCreator"
    "roles/storage.objectViewer"
    "roles/storage.admin"
    "roles/container.admin"
    "roles/iam.serviceAccountAdmin"
    "roles/iam.serviceAccountUser"
  )

  for ROLE in "${ROLES[@]}"; do
    gcloud projects remove-iam-policy-binding $PROJECT_ID \
      --member="serviceAccount:$SERVICE_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com" \
      --role="$ROLE" --quiet || echo "Role $ROLE was not found for the service account."
  done
}

# Function to delete the service account if it exists
delete_service_account() {
  if gcloud iam service-accounts describe "$SERVICE_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com" &>/dev/null; then
    echo "Deleting Service Account: $SERVICE_ACCOUNT_NAME"
    gcloud iam service-accounts delete "$SERVICE_ACCOUNT_NAME@$PROJECT_ID.iam.gserviceaccount.com" --quiet
  else
    echo "Service Account $SERVICE_ACCOUNT_NAME does not exist or has already been deleted."
  fi
}

# Delete the Workload Identity Provider
delete_workload_identity_provider

# Delete the Workload Identity Pool
delete_workload_identity_pool

# Remove IAM policy bindings
remove_iam_policy_bindings

# Delete the Service Account
delete_service_account

echo "Cleanup of Workload Identity Federation setup and Service Account is complete."
