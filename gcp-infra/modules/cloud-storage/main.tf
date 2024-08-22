resource "google_storage_bucket" "bucket" {
  name                        = var.bucket_name
  location                    = var.location
  force_destroy               = var.force_destroy
  uniform_bucket_level_access = var.uniform_bucket_level_access

  lifecycle_rule {
    action {
      type = "Delete"
    }

    condition {
      age        = var.lifecycle_age
      with_state = "ANY"
    }
  }
}
