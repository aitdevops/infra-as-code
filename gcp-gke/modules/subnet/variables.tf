variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  type        = string
  description = "The GCP region"
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}
