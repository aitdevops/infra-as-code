terraform {
  backend "gcs" {
    bucket  = "terraform-state-aitdevops"
    prefix  = "terraform/state"
  }
}