# Backend configuration (hardcoded)
terraform {
  backend "azurerm" {
    resource_group_name   = "aitdevops"  # Hardcoded resource group name for backend storage
    storage_account_name  = "terraformstateaitdevops"  # Hardcoded storage account name
    container_name        = "terraformstateaitdevops"  # Hardcoded container name for the state file
    key                   = "terraform.tfstate"  # Name of the state file

    # OIDC related values (hardcoded for backend)
    subscription_id       = "6e5394a9-f79c-4c60-9252-45d6d4a0f88c"  # Hardcoded subscription ID for backend
    tenant_id             = "4c470cc0-914e-41d8-b3f2-2812cb01d186"  # Hardcoded tenant ID for backend
    client_id             = "d385aa71-0f89-4204-964c-2cbb4322fcc0"  # Hardcoded client ID for backend
  }
}

# Azure Provider block (variables can still be used here)
provider "azurerm" {
  features {}

  # OIDC related values for provider (can use variables here)
  use_oidc        = true
  subscription_id = var.azure_subscription_id  # Azure Subscription ID for provider
  tenant_id       = var.azure_tenant_id  # Azure Tenant ID for provider
  client_id       = var.azure_client_id  # Azure Client ID for provider
}

# Resource Group block (dynamic)
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Storage Account block (dynamic)
resource "azurerm_storage_account" "sa" {
  name                     = var.storage_account_name
  resource_group_name       = azurerm_resource_group.rg.name
  location                  = azurerm_resource_group.rg.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
}

# Storage Container block (dynamic)
resource "azurerm_storage_container" "state_container" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}
