output "cloud_run_service_url" {
  description = "The URL to access the deployed Cloud Run service"
  value       = google_cloud_run_service.send_approval_email.status[0].url
}

# output "eventarc_trigger_name" {
#   description = "The name of the Eventarc trigger"
#   value       = google_eventarc_trigger.http_trigger.name
# }
