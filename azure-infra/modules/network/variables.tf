variable "prefix" {
  type        = string
  description = "Prefix for resource names"
}

variable "location" {
  type        = string
  description = "Azure location for the resources"
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "address_space" {
  type        = list(string)
  description = "Address space for the virtual network"
}

variable "address_prefixes" {
  type        = list(string)
  description = "Address prefixes for the subnet"
}
