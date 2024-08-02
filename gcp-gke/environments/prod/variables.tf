variable "project_id" {
  description = "The GCP project ID"
  type        = string
  default     = "aitdevops8"
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The GCP zone"
  type        = string
  default     = "us-central1-a"
}

variable "cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
  default     = "aitdevops-gke"
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "prod-vpc"
}

variable "subnet_name" {
  description = "The name of the subnet"
  type        = string
  default     = "prod-vpc-private-subnet"

}

variable "node_count" {
  description = "number of nodes"
  type        = number
  default     = 1
}

variable "node_machine_type" {
  description = "The machine type for the nodes"
  type        = string
  default     = "e2-medium"
}

variable "min_node_count" {
  description = "min node count"
  type        = number
  default     = 1
}

variable "max_node_count" {
  description = "max node count"
  type        = number
  default     = 1
}