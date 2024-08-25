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
  default     = "us-central1"
}

variable "domain_name" {
  description = "The domain name for the managed zone"
  type        = string
}
#####################url########################
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

variable "dns_managed_zone" {
  description = "The name of the DNS managed zone"
  type        = string
}
#####################IP########################
variable "a_record_ip" {
  description = "The IP address to set in the site record"
  type        = string
}