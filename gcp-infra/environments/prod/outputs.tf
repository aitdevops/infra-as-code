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
#####################DNS########################
output "dns_zone_name" {
  description = "The name of the DNS managed zone"
  value       = module.cloud-dns.dns_zone_name
}

output "dns_name_servers" {
  description = "The name servers for the managed zone"
  value       = module.cloud-dns.dns_name_servers
}

output "a_record" {
  description = "The IP address set in the site record"
  value       = module.cloud-dns.a_record
}

output "b_record" {
  description = "The IP address set in the site record"
  value       = module.cloud-dns.b_record
}

output "c_record" {
  description = "The IP address set in the auth record"
  value       = module.cloud-dns.c_record
}

output "d_record" {
  description = "The IP address set in the user record"
  value       = module.cloud-dns.d_record
}

output "e_record" {
  description = "The IP address set in the approval record"
  value       = module.cloud-dns.e_record
}
output "f_record" {
  description = "The IP address set in the db record"
  value       = module.cloud-dns.f_record
}
output "redis_record" {
  description = "The IP address set in the redis record"
  value       = module.cloud-dns.redis_record
}


