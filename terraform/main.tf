provider "google" {
  project = "devops-projects-426703"
}

resource "google_service_account" "wif_service_account" {
  account_id   = "wif-works-sa"
  display_name = "WIF Works Service Account"
  description  = "Service account for Workload Identity Federation"
}
