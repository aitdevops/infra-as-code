output "service_account_email" {
  description = "The email of the service account created"
  value       = google_service_account.terraform_gke.email
}
