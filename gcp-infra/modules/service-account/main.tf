provider "kubernetes" {
  config_path = "~/.kube/config"
}

# Service Account for GKE
resource "google_service_account" "terraform_gke" {
  account_id   = "terraform-gke"
  display_name = "Terraform GKE"
  description  = "Service account for Terraform to manage gcloud services"
}

# IAM Roles for the Service Account
resource "google_project_iam_member" "iam_bindings" {
  for_each = toset([
    "roles/compute.viewer",
    "roles/compute.securityAdmin",
    "roles/container.admin",
    "roles/container.clusterAdmin",
    "roles/container.developer",
    "roles/container.serviceAgent",
    "roles/iam.serviceAccountAdmin",
    "roles/iam.serviceAccountUser",
    "roles/resourcemanager.projectIamAdmin",
    "roles/artifactregistry.admin",
    "roles/dns.admin",
    "roles/iam.serviceAccountUser",
    "roles/artifactregistry.reader"
  ])

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.terraform_gke.email}"
}