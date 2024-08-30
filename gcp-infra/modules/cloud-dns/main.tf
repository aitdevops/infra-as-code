resource "google_dns_managed_zone" "dns_zone" {
  name        = var.dns_managed_zone
  dns_name    = var.domain_name
  description = "Managed DNS zone for ${var.domain_name}"


  dnssec_config {
    state         = "on"
    non_existence = "nsec3"
  }

  visibility = "public"
}

#####################site########################
resource "google_dns_record_set" "a_record" {
  name         = "${var.name}."
  type         = "A"
  ttl          = 300
  managed_zone = google_dns_managed_zone.dns_zone.name

  rrdatas = [var.a_record_ip]
}
###################argo########################
resource "google_dns_record_set" "b_record" {
  name         = "${var.argo_service}."
  type         = "A"
  ttl          = 300
  managed_zone = google_dns_managed_zone.dns_zone.name

  rrdatas = [var.a_record_ip]
}
#####################auth########################
resource "google_dns_record_set" "c_record" {
  name         = "${var.auth_service}."
  type         = "A"
  ttl          = 300
  managed_zone = google_dns_managed_zone.dns_zone.name

  rrdatas = [var.a_record_ip]
}
#####################user########################
resource "google_dns_record_set" "d_record" {
  name         = "${var.user_service}."
  type         = "A"
  ttl          = 300
  managed_zone = google_dns_managed_zone.dns_zone.name

  rrdatas = [var.a_record_ip]
}
#####################approval########################
resource "google_dns_record_set" "e_record" {
  name         = "${var.approval_service}."
  type         = "A"
  ttl          = 300
  managed_zone = google_dns_managed_zone.dns_zone.name

  rrdatas = [var.a_record_ip]
}
#####################databse########################
resource "google_dns_record_set" "f_record" {
  name         = "${var.database_service}."
  type         = "A"
  ttl          = 300
  managed_zone = google_dns_managed_zone.dns_zone.name

  rrdatas = [var.db_ip]
}
#####################databse########################
resource "google_dns_record_set" "redis_record" {
  name         = "${var.redis_service}."
  type         = "A"
  ttl          = 300
  managed_zone = google_dns_managed_zone.dns_zone.name

  rrdatas = [var.redis_ip]
}