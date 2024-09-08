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
