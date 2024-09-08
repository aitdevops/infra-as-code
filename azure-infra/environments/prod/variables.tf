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
variable "vnet_name" {
  description = "The name of the VNet to create."
  type        = string
}

variable "address_space" {
  description = "The address space of the VNet."
  type        = list(string)
}


variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
}

variable "tags" {
  description = "Tags to assign to the resources."
  type        = map(string)
}

variable "private_subnet_name" {
  description = "The name of the private subnet."
  type        = string
}

variable "private_subnet_address_prefixes" {
  description = "The address prefixes for the private subnet."
  type        = list(string)
}

variable "nat_gateway_name" {
  description = "The name of the NAT gateway."
  type        = string
}

