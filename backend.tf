terraform {
  backend "gcs" {
    bucket = "terraform-state-aitdevops-env"
    prefix = "terraform/state"
  }
}
