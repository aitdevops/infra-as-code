provider "azurerm" {
  features {}
}

# Configure the Azure backend for state storage
terraform {
  backend "azurerm" {
    resource_group_name   = "aitdevops"
    storage_account_name  = "terraformstateaitdevops"
    container_name        = "terraformstateaitdevops"
    key                   = "terraform.tfstate"
  }
}

# Define resource group (if creating new resources)
resource "azurerm_resource_group" "rg" {
  name     = "aitdevops"
  location = "East US"  # Adjust based on your region
}

# Example: Creating a virtual network (you can adjust resources as per your needs)
resource "azurerm_virtual_network" "example_vnet" {
  name                = "example-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# Add other resources as needed here
