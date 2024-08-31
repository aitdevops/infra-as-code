variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}
variable "vpc_self_link" {
  description = "The self-link of the VPC network"
  type        = string
}
