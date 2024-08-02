resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = var.vpc_name
  subnetwork = var.subnet_name

  node_locations = [var.zone]

  ip_allocation_policy {
    cluster_secondary_range_name = "pods"
    services_secondary_range_name = "services"
  }

  private_cluster_config {
    enable_private_nodes    = true
    enable_private_endpoint = false
    master_ipv4_cidr_block  = "172.16.0.0/28"
  }

  master_authorized_networks_config {
    cidr_blocks {
      cidr_block   = "0.0.0.0/0"
      display_name = "All networks"
    }
  }

  addons_config {
    http_load_balancing {
      disabled = false
    }

    horizontal_pod_autoscaling {
      disabled = false
    }

    network_policy_config {
      disabled = false
    }
  }
}

resource "google_container_node_pool" "primary_nodes" {
  cluster    = google_container_cluster.primary.name
  location   = var.region
  node_count = var.node_count

  node_config {
    machine_type = var.node_machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
    labels = {
      env = "prod"
    }
    tags = ["gke-node", "prod"]
  }

  autoscaling {
    min_node_count = var.min_node_count
    max_node_count = var.max_node_count
  }
}


resource "google_container_node_pool" "additional_nodes" {
  cluster    = google_container_cluster.primary.name
  location   = var.region
  node_count = var.additional_node_count

  node_config {
    machine_type = var.additional_node_machine_type
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
    labels = {
      env = "prod"
    }
    tags = ["gke-node", "prod"]
  }

  autoscaling {
    min_node_count = var.additional_min_node_count
    max_node_count = var.additional_max_node_count
  }
}
