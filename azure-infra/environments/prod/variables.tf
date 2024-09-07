# Azure subscription details
variable "azure_subscription_id" {
  description = "Azure Subscription ID where resources will be created."
  type        = string
}

variable "azure_tenant_id" {
  description = "Azure Tenant ID for authentication."
  type        = string
}

variable "azure_client_id" {
  description = "Azure Client ID for OIDC authentication."
  type        = string
}

# Backend details for state storage
variable "backend_resource_group_name" {
  description = "Resource group name for Terraform state storage."
  type        = string
  default     = "aitdevops-prod"
}

variable "backend_storage_account_name" {
  description = "Storage account name for Terraform state storage."
  type        = string
  default     = "terraformstateaitdevops-prod"
}

variable "backend_container_name" {
  description = "Container name for storing the state file."
  type        = string
  default     = "prod"
}

variable "backend_key" {
  description = "Name of the state file."
  type        = string
  default     = "prod.tfstate"
}

# Resource group details
variable "resource_group_name" {
  description = "The name of the resource group to create."
  type        = string
  default     = "ait-prod"
}

variable "location" {
  description = "Azure region where the resource group will be created."
  type        = string
  default     = "East US"
}
