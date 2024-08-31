resource "google_compute_subnetwork" "private_subnet" {
  name                     = "${var.vpc_name}-private-subnet"
  ip_cidr_range            = "10.0.1.0/24"
  region                   = var.region
  network                  = var.vpc_self_link
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = "10.0.8.0/21"
  }

  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = "10.0.16.0/21"
  }
}

resource "google_compute_subnetwork" "public_subnet" {
  name          = "${var.vpc_name}-public-subnet"
  ip_cidr_range = "10.0.4.0/24"
  region        = var.region
  network       = var.vpc_self_link
}
