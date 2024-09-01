variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
}

variable "zone" {
  description = "The GCP zone"
  type        = string
}

variable "cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}

variable "node_pools" {
  description = "List of node pools with their configurations"
  type = list(object({
    name              = string
    node_count        = number
    node_machine_type = string
    min_node_count    = number
    max_node_count    = number
  }))
}
variable "namespaces" {
  description = "A list of namespaces where the service account should be created"
  type        = list(string)
}
variable "gke_service_account_email" {
  description = "The email of the GKE service account to be used by the node pool"
  type        = string
}

variable "gke_service_account_name" {
  description = "The name of the GKE service account"
  type        = string
}
variable "kubernetes_token" {
  description = "The token used to authenticate the Kubernetes provider"
  type        = string
}
