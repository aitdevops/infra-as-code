variable "vnet_name" {
  description = "The name of the VNet to create."
  type        = string
}

variable "address_space" {
  description = "The address space of the VNet."
  type        = list(string)
}

variable "location" {
  description = "The Azure region where the resources will be created."
  type        = string
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

variable "public_ip_address_id" {
  description = "The ID of the public IP address associated with the NAT gateway."
  type        = string
}
