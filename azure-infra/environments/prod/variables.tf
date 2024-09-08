# Resource variables
variable "rg_group_name" {
  description = "The name of the resource group to create."
  type        = string
}
# provider variables
variable "location" {
  description = "Azure region where the resource group will be created."
  type        = string
}
variable "azure_subscription_id" {
  type        = string
  description = "Azure Subscription ID used for Terraform"
}

variable "azure_tenant_id" {
  type        = string
  description = "Azure Tenant ID used for Terraform"
}

variable "azure_client_id" {
  type        = string
  description = "Azure Client ID used for Terraform"
}
# vnet variables


variable "prefix" {
  type        = string
  description = "Prefix for resource names"
}

