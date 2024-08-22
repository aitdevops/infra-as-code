output "bucket_name" {
  description = "The name of bucket"
  value       = google_storage_bucket.bucket.name
}
output "location" {
  description = "The location of bucket"
  value       = google_storage_bucket.bucket.location
}