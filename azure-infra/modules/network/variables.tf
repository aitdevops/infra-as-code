variable "vnet_name" {
  type        = string
  description = "The name of the virtual network."
}

variable "address_space" {
  type        = list(string)
  description = "The address space of the virtual network."
}

variable "location" {
  type        = string
  description = "The Azure region where the resources should be created."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group."
}


variable "private_subnet_name" {
  type        = string
  description = "The name of the private subnet."
}


variable "nat_gateway_name" {
  type        = string
  description = "The name of the NAT gateway."
}

variable "public_ip_address_id" {
  description = "The ID of the public IP address associated with the NAT gateway."
  type        = string
}
