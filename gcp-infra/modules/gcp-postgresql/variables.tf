variable "instance_name" {
  description = "The name of the PostgreSQL instance."
  type        = string
}

variable "region" {
  description = "The region where the PostgreSQL instance will be created."
  type        = string
}

variable "instance_tier" {
  description = "The machine type tier for the PostgreSQL instance."
  type        = string
}

variable "private_network" {
  description = "The VPC network to attach the PostgreSQL instance to."
  type        = string
}

variable "database_name" {
  description = "The name of the default database to create."
  type        = string
}

variable "project_id" {
  description = "The ID of the project in which resources will be created."
  type        = string
}
