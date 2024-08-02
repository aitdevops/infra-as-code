output "gke_cluster_name" {
  value = module.gke.cluster_name
}

output "gke_cluster_endpoint" {
  value = module.gke.endpoint
}

output "gke_cluster_master_version" {
  value = module.gke.master_version
}
