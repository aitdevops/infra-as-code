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
  description = "The name of the vnet to create."
  type        = string
}
variable "location" {
  description = "The name of the location to create."
  type        = string
}
variable "resource_group_name" {
  description = "The name of the resource_group to use."
  type        = string
}
variable "private_subnet_name" {
  description = "The name of the private_subnet to create."
  type        = string
}
variable "nat_gateway_name" {
  description = "The name of the nat_gateway to create."
  type        = string
}


