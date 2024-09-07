provider "azurerm" {
  features {}

  # Ensure that the provider uses the environment variables provided by OIDC login
  use_oidc = true
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
