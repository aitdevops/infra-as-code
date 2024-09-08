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

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}
variable "prefix" {
  type        = string
  description = "Prefix for resource names"
}
variable "address_space" {
  type        = list(string)
  description = "Address space for the virtual network"
}

variable "address_prefixes" {
  type        = list(string)
  description = "Address prefixes for the subnet"
}
variable "node_count" {
  type        = number
  description = "Number of nodes in the default node pool"
  default     = 1
}

variable "vm_size" {
  type        = string
  description = "VM size for the default node pool"
  default     = "Standard_DS2_v2"
}