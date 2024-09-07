# Resource group details
variable "rg_group_name" {
  description = "The name of the resource group to create."
  type        = string
}

variable "location" {
  description = "Azure region where the resource group will be created."
  type        = string
}
variable "subscription_id" {
  type        = string
  description = "Azure subscription ID"
}

variable "tenant_id" {
  type        = string
  description = "Azure tenant ID"
}

variable "client_id" {
  type        = string
  description = "Azure client ID"
}
