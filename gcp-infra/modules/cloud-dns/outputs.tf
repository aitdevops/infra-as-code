output "dns_zone_name" {
  description = "The name of the DNS managed zone"
  value       = google_dns_managed_zone.dns_zone.name
}

output "dns_name_servers" {
  description = "The name servers for the managed zone"
  value       = google_dns_managed_zone.dns_zone.name_servers
}

output "a_record_ip" {
  description = "The IP address set in the A record"
  value       = google_dns_record_set.a_record.rrdatas[0]
}
