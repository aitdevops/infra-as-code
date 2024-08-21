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

variable "cluster_location" {
  description = "The location of the GKE cluster (region or zone)"
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
    name               = string
    node_count         = number
    node_machine_type  = string
    min_node_count     = number
    max_node_count     = number
  }))
}

variable "database_name" {
  description = "The name of the PostgreSQL database"
  type        = string
}

variable "credentials_file_path" {
  description = "Path to the GCP credentials file"
  type        = string
}

variable "postgres_instance_name" {
  description = "The name of the PostgreSQL instance."
  type        = string
}

variable "postgres_instance_tier" {
  description = "The machine type tier for the PostgreSQL instance."
  type        = string
}
