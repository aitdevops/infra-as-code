output "dns_zone_name" {
  description = "The name of the DNS managed zone"
  value       = google_dns_managed_zone.dns_zone.name
}

output "dns_name_servers" {
  description = "The name servers for the managed zone"
  value       = google_dns_managed_zone.dns_zone.name_servers
}

output "a_record" {
  description = "The IP address set in the A record"
  value       = google_dns_record_set.a_record.rrdatas[0]
}

output "b_record" {
  description = "The IP address set in the argo record"
  value       = google_dns_record_set.b_record.rrdatas[0]
}

output "c_record" {
  description = "The IP address set in the auth record"
  value       = google_dns_record_set.c_record.rrdatas[0]
}

output "d_record" {
  description = "The IP address set in the user record"
  value       = google_dns_record_set.d_record.rrdatas[0]
}

output "e_record" {
  description = "The IP address set in the approval record"
  value       = google_dns_record_set.e_record.rrdatas[0]
}
output "f_record" {
  description = "The IP address set in the database record"
  value       = google_dns_record_set.e_record.rrdatas[0]
}