# GKE Cluster with Workload Identity
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

# Node Pool with Service Account
resource "google_container_node_pool" "node_pools" {
  for_each = { for np in var.node_pools : np.name => np }

  cluster    = google_container_cluster.primary.name
  location   = var.region
  node_count = each.value.node_count

  node_config {
    machine_type = each.value.node_machine_type
    service_account = var.gke_service_account_email  # Assign the service account to the node pool

    preemptible  = false
    oauth_scopes = [
      "https://www.googleapis.com/auth/cloud-platform",
    ]
  }

  autoscaling {
    min_node_count = each.value.min_node_count
    max_node_count = each.value.max_node_count
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

# IAM Binding for Workload Identity
resource "google_service_account_iam_binding" "gke_workload_identity_binding" {
  service_account_id = var.gke_service_account_name
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "serviceAccount:${var.project_id}.svc.id.goog[frontend/k8s-service-account]",
    "serviceAccount:${var.project_id}.svc.id.goog[backend/k8s-service-account]",
  ]
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

# Kubernetes Service Account
resource "kubernetes_service_account" "ksa" {
  for_each = toset(var.namespaces)

  metadata {
    name      = "k8s-service-account"
    namespace = each.value  # Create the service account in each namespace
    annotations = {
      "iam.gke.io/gcp-service-account" = var.gke_service_account_email
    }
  }
}
