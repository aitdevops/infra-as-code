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
variable "vpc_self_link" {
  description = "The self-link of the VPC network"
  type        = string
}
