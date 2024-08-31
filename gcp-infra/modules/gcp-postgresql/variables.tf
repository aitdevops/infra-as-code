variable "vpc_self_link" {
  description = "The self-link of the VPC network"
  type        = string
}

variable "instance_name" {
  description = "The name of the SQL instance"
  type        = string
}

variable "region" {
  description = "The region where the SQL instance will be created"
  type        = string
}

variable "instance_tier" {
  description = "The tier (machine type) for the SQL instance"
  type        = string
}

variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "database_name" {
  description = "The name of the default database to create in the instance"
  type        = string
}
