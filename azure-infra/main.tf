provider "azurerm" {
  features {}

  # Use OIDC authentication instead of Azure CLI
  use_oidc = true

  # Optional, but you can also reference the environment variables explicitly
  subscription_id = var.azure_subscription_id
  tenant_id       = var.azure_tenant_id
  client_id       = var.azure_client_id
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
