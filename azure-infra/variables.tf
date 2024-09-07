# Azure Subscription ID
variable "azure_subscription_id" {
  description = "Azure Subscription ID where resources will be created."
  type        = string
}

# Azure Tenant ID
variable "azure_tenant_id" {
  description = "Azure Tenant ID for authentication."
  type        = string
}

# Azure Client ID
variable "azure_client_id" {
  description = "Azure Client ID for OIDC authentication."
  type        = string
}

# Resource Group Name
variable "resource_group_name" {
  description = "The name of the resource group to create."
  type        = string
  default     = "aitdevops"  # You can replace this with the desired name.
}

# Location for the Resource Group
variable "location" {
  description = "Azure region where the resource group will be created."
  type        = string
  default     = "East US"  # You can replace this with your preferred Azure region.
}
variable "resourc_group_name" {
  description = "The name of the resource group to create."
  type        = string
  default     = "ait"  # You can replace this with the desired name.
}