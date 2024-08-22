output "vpc_name" {
  value = google_compute_network.vpc_network.name
}

output "nat_router_name" {
  value = google_compute_router.nat_router.name
}

output "nat_gateway_name" {
  value = google_compute_router_nat.nat_gateway.name
}
