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

# Variable for Resource Group name
variable "resource_group_name" {
  description = "The name of the resource group to create and hold the storage account."
  type        = string
  default     = "aitdevops"  # You can customize this.
}

# Variable for the Azure region (location)
variable "location" {
  description = "Azure region where the resources will be deployed."
  type        = string
  default     = "East US"  # You can change this to the desired Azure region.
}

# Variable for the Storage Account name
variable "storage_account_name" {
  description = "The name of the storage account to store Terraform state."
  type        = string
  default     = "terraformstateaitdevops"  # Storage account name.
}

# Variable for the Blob Container name
variable "container_name" {
  description = "The name of the blob container to store the Terraform state file."
  type        = string
  default     = "terraformstateaitdevops"  # Container name for state file storage.
}
