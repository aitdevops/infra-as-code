terraform {
  backend "azurerm" {
    resource_group_name   = "aitdevops"
    storage_account_name  = "terraformstateaitdevops"
    container_name        = "terraformstateaitdevops"
    key                   = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
}

# Define resource group
resource "azurerm_resource_group" "rg" {
  name     = "aitdevops"
  location = "East US"
}

# Example: Creating a virtual network
resource "azurerm_virtual_network" "example_vnet" {
  name                = "example-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Output for resource group and virtual network
output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "vnet_id" {
  value = azurerm_virtual_network.example_vnet.id
}
