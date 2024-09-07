# Variable for Azure Subscription ID
variable "azure_subscription_id" {
  description = "Azure Subscription ID where resources will be created."
  type        = string
}

# Variable for Azure Tenant ID
variable "azure_tenant_id" {
  description = "Azure Tenant ID for authentication."
  type        = string
}

# Variable for Azure Client ID
variable "azure_client_id" {
  description = "Azure Client ID for OIDC authentication."
  type        = string
}

# Variables for backend configuration
variable "backend_resource_group_name" {
  description = "Name of the resource group where the backend state is stored"
  type        = string
}

variable "backend_storage_account_name" {
  description = "Name of the storage account where the backend state is stored"
  type        = string
}

variable "backend_container_name" {
  description = "Name of the container where the backend state is stored"
  type        = string
}

# Variables for creating resources
variable "resource_group_name" {
  description = "Name of the resource group to create"
  type        = string
  default     = "aitdevops"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "East US"
}

variable "storage_account_name" {
  description = "Name of the storage account to create"
  type        = string
  default     = "terraformstateaitdevops"
}

variable "container_name" {
  description = "Name of the container to create"
  type        = string
  default     = "terraformstateaitdevops"
}
