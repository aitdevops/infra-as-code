output "cluster_name" {
  value = google_container_cluster.primary.name
}

output "endpoint" {
  value = google_container_cluster.primary.endpoint
}

output "master_version" {
  value = google_container_cluster.primary.master_version
}
output "master_auth" {
  value = google_container_cluster.primary.master_auth
}