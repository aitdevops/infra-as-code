resource "google_compute_subnetwork" "private_subnet" {
  name                     = "${var.vpc_name}-private-subnet"
  ip_cidr_range            = "10.0.1.0/24"
  region                   = var.region
  network                  = google_compute_network.vpc_network.name
  private_ip_google_access = true

  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = "10.0.8.0/21"
  }

  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = "10.0.16.0/21"
  }

  depends_on = [google_compute_network.vpc_network]
}

resource "google_compute_subnetwork" "public_subnet" {
  name          = "${var.vpc_name}-public-subnet"
  ip_cidr_range = "10.0.4.0/24"
  region        = var.region
  network       = google_compute_network.vpc_network.name

  depends_on = [google_compute_network.vpc_network]
}