# Resource group details
variable "rg_group_name" {
  description = "The name of the resource group to create."
  type        = string
}

variable "location" {
  description = "Azure region where the resource group will be created."
  type        = string
}
