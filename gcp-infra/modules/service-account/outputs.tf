output "service_account_email" {
  description = "The email of the service account created"
  value       = google_service_account.terraform_gke.email
}
output "gke_service_account_email" {
  value = google_service_account.terraform_gke.email
}

output "gke_service_account_name" {
  value = google_service_account.terraform_gke.name
}

