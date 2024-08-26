#####################GCP########################
variable "project_id" {
  description = "The GCP project ID"
  type        = string
}
variable "credentials_file_path" {
  description = "Path to the GCP credentials file"
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
#####################VPC########################
variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
}
#####################GKE########################
variable "cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
}

variable "cluster_location" {
  description = "The location of the GKE cluster (region or zone)"
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
variable "namespaces" {
  description = "A list of namespaces where the service account should be created"
  type        = list(string)
}
#####################PostgreSQL########################
variable "database_name" {
  description = "The name of the PostgreSQL database"
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
#####################Cloud-DNS########################
variable "domain_name" {
  description = "The domain name for the managed zone"
  type        = string
}

variable "name" {
  description = "site url"
  type        = string
}

variable "argo_service" {
  description = "site url"
  type        = string
}

variable "auth_service" {
  description = "site url"
  type        = string
}

variable "user_service" {
  description = "site url"
  type        = string
}

variable "approval_service" {
  description = "site url"
  type        = string
}
variable "database_service" {
  description = "site url"
  type        = string
}

variable "dns_managed_zone" {
  description = "The name of the DNS managed zone"
  type        = string
}

variable "a_record_ip" {
  description = "The IP address to set in the site record"
  type        = string
}
variable "db_ip" {
  description = "The IP address to set in the site record"
  type        = string
}
##################Cloud-Storage########################
variable "bucket_name" {
  description = "The name of the storage bucket."
  type        = string
}

variable "location" {
  description = "The location of the storage bucket (e.g., US, EU, ASIA)."
  type        = string
}

variable "force_destroy" {
  description = "Whether to allow Terraform to destroy the bucket if it contains objects."
  type        = bool
}

variable "uniform_bucket_level_access" {
  description = "Whether to enable uniform bucket-level access."
  type        = bool
}

variable "lifecycle_age" {
  description = "The age of objects before they are deleted by lifecycle management."
  type        = number
}
