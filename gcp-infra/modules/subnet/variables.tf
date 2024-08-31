variable "vpc_self_link" {
  description = "The self-link of the VPC network"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC network"
  type        = string
}

variable "region" {
  description = "The region where the subnets will be created"
  type        = string
}

variable "project_id" {
  description = "The GCP project ID"
  type        = string
}
