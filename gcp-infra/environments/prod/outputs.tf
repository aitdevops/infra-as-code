#####################GKE########################
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
#####################SERVICE-ACCOUNT########################

output "service_account_email" {
  description = "Service account email"
  value       = module.service_account.service_account_email
}
#####################DNS########################
output "dns_zone_name" {
  description = "The name of the DNS managed zone"
  value       = module.cloud-dns.dns_zone_name
}

output "dns_name_servers" {
  description = "The name servers for the managed zone"
  value       = module.cloud-dns.dns_name_servers
}

output "a_record_ip" {
  description = "The IP address set in the A record"
  value       = module.cloud-dns.a_record_ip
}
#####################Cloud-Storage########################
output "bucket_name" {
  description = "The name of bucket"
  value       = module.cloud_storage.bucket_name
}
output "location" {
  description = "The location of bucket"
  value       = module.cloud_storage.location
}