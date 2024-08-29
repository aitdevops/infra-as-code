# Storage bucket to store the function code
resource "google_storage_bucket" "function_bucket" {
  name          = "test-functions"
  location      = var.region
  force_destroy = true
}

# Upload function code to the storage bucket
resource "google_storage_bucket_object" "function_zip" {
  name   = "sendApprovalEmail.zip"
  bucket = google_storage_bucket.function_bucket.name
  source = var.zip_file
}

# Build and push the Docker image to Google Container Registry
resource "null_resource" "build_and_push_image" {
  provisioner "local-exec" {
    command = <<EOT
      docker run --rm --platform linux/amd64 -v $(pwd):/workspace -w /workspace \
        gcr.io/cloud-builders/gcloud \
        builds submit --tag gcr.io/${var.project_id}/send-approval-email:latest .
    EOT
  }
}

# Deploy Cloud Run Service (Gen 2 Cloud Function)
resource "google_cloud_run_service" "send_approval_email" {
  name     = "send-approval-email"
  location = var.region

  template {
    spec {
      containers {
        image = "gcr.io/${var.project_id}/send-approval-email:latest"
        env {
          name  = "NODE_ENV"
          value = "production"
        }
      }
      service_account_name = var.service_account_email
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }

  autogenerate_revision_name = true
}

# IAM Policy Binding for Cloud Run Invoker
resource "google_cloud_run_service_iam_member" "invoker" {
  location    = google_cloud_run_service.send_approval_email.location
  service     = google_cloud_run_service.send_approval_email.name
  role        = "roles/run.invoker"
  member      = "allUsers"
}
