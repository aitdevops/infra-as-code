resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.region

  remove_default_node_pool = true
  initial_node_count       = 1

  network    = var.vpc_name
  subnetwork = var.subnet_name

  node_locations = [var.zone]

  ip_allocation_policy {
    cluster_secondary_range_name  = "pods"
    services_secondary_range_name = "services"
  }

  workload_identity_config {
    workload_pool = "${var.project_id}.svc.id.goog"
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
      disabled = true
    }
  }

  deletion_protection = false  # Disable deletion protection here
}

# Node Pool for Frontend Workloads
resource "google_container_node_pool" "frontend_pool" {
  cluster  = google_container_cluster.primary.name
  location = var.region

  node_count = 1

  node_config {
    machine_type    = "e2-medium"
    service_account = var.gke_service_account_email
    labels = {
      role = "frontend-pool"
    }

    # No taints for frontend, allowing all pods with matching affinity to be scheduled
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  autoscaling {
    min_node_count = 1
    max_node_count = 1
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  upgrade_settings {
    max_surge       = 1
    max_unavailable = 0
  }
}

# Node Pool for Backend Workloads
resource "google_container_node_pool" "backend_pool" {
  cluster  = google_container_cluster.primary.name
  location = var.region

  node_count = 1

  node_config {
    machine_type    = "e2-medium"
    service_account = var.gke_service_account_email

    labels = {
      role = "backend-pool"
    }

    # No taints for backend, allowing all pods with matching affinity to be scheduled
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  autoscaling {
    min_node_count = 1
    max_node_count = 1
  }

  management {
    auto_repair  = true
    auto_upgrade = true
  }

  upgrade_settings {
    max_surge       = 1
    max_unavailable = 0
  }
}
