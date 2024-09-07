provider "azurerm" {
  features {}
  use_oidc = true  # Ensure OIDC is enabled for the AzureRM provider
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
