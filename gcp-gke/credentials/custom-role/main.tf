terraform {
  backend "gcs" {
    bucket  = "terraform-state-aitdevops"
    prefix  = "terraform/state"
  }
}

provider "google" {
  credentials = file("/Users/rajeev/.config/gcloud/application_default_credentials.json")
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}

variable "project_id" {
  description = "The ID of the GCP project"
  type        = string
}

variable "region" {
  description = "The region to deploy resources in"
  type        = string
}

variable "zone" {
  description = "The zone to deploy resources in"
  type        = string
}

resource "google_service_account" "terraform_gke" {
  account_id   = "terraform-gke"
  display_name = "Terraform GKE"
  description  = "Service account for Terraform to manage GKE clusters"
}

resource "google_project_iam_member" "compute_viewer" {
  project = var.project_id
  role    = "roles/compute.viewer"
  member  = "serviceAccount:${google_service_account.terraform_gke.email}"
}

resource "google_project_iam_member" "compute_security_admin" {
  project = var.project_id
  role    = "roles/compute.securityAdmin"
  member  = "serviceAccount:${google_service_account.terraform_gke.email}"
}

resource "google_project_iam_member" "container_cluster_admin" {
  project = var.project_id
  role    = "roles/container.clusterAdmin"
  member  = "serviceAccount:${google_service_account.terraform_gke.email}"
}

resource "google_project_iam_member" "container_developer" {
  project = var.project_id
  role    = "roles/container.developer"
  member  = "serviceAccount:${google_service_account.terraform_gke.email}"
}

resource "google_project_iam_member" "iam_service_account_admin" {
  project = var.project_id
  role    = "roles/iam.serviceAccountAdmin"
  member  = "serviceAccount:${google_service_account.terraform_gke.email}"
}

resource "google_project_iam_member" "iam_service_account_user" {
  project = var.project_id
  role    = "roles/iam.serviceAccountUser"
  member  = "serviceAccount:${google_service_account.terraform_gke.email}"
}

resource "google_project_iam_member" "resourcemanager_project_iam_admin" {
  project = var.project_id
  role    = "roles/resourcemanager.projectIamAdmin"
  member  = "serviceAccount:${google_service_account.terraform_gke.email}"
}
