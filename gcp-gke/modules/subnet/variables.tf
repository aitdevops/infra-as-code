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

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
  default     = "prod-vpc"
}
