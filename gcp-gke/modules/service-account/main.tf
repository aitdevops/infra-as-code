resource "google_service_account" "terraform_gke" {
  account_id   = "terraform-gke"
  display_name = "Terraform GKE"
  description  = "Service account for Terraform to manage GKE clusters"
}

resource "google_project_iam_member" "iam_bindings" {
  for_each = toset([
    "roles/compute.viewer",
    "roles/compute.securityAdmin",
    "roles/container.clusterAdmin",
    "roles/container.developer",
    "roles/iam.serviceAccountAdmin",
    "roles/iam.serviceAccountUser",
    "roles/resourcemanager.projectIamAdmin"
  ])

  project = var.project_id
  role    = each.value
  member  = "serviceAccount:${google_service_account.terraform_gke.email}"
}
