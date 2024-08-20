output "gke_cluster_name" {
  description = "The name of the GKE cluster"
  value       = module.gke.cluster_name
}

output "gke_cluster_endpoint" {
  description = "The endpoint of the GKE cluster"
  value       = module.gke.endpoint
}

output "gke_cluster_master_version" {
  description = "The master version of the GKE cluster"
  value       = module.gke.master_version
}

output "service_account_email" {
  description = "service account email"
  value = module.service_account.service_account_email
}