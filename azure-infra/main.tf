provider "azurerm" {
  features {}
  tenant_id  = "4c470cc0-914e-41d8-b3f2-2812cb01d186"  # Tenant ID
  client_id  = "d385aa71-0f89-4204-964c-2cbb4322fcc0"  # Client ID
  use_oidc   = true
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
