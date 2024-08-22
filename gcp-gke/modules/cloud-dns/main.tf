provider "google" {
  project     = var.project_id
  credentials = file(var.credentials_file_path)
  region      = var.region
}

resource "google_dns_managed_zone" "dns_zone" {
  name        = var.dns_managed_zone
  dns_name    = var.domain_name
  description = "Managed DNS zone for ${var.domain_name}"


  dnssec_config {
    state        = "on"
    non_existence = "nsec3"
  }

  visibility = "public"
}

resource "google_dns_record_set" "a_record" {
  name         = "www.${var.name}."
  type         = "A"
  ttl          = 300
  managed_zone = google_dns_managed_zone.dns_zone.name

  rrdatas = [var.a_record_ip]
}
