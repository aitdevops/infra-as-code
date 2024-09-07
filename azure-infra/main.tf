# Backend configuration (hardcoded with tenant_id, client_id, and subscription_id)
terraform {
  backend "azurerm" {
    resource_group_name   = "aitdevops"  # Hardcoded resource group name for backend storage
    storage_account_name  = "terraformstateaitdevops"  # Hardcoded storage account name
    container_name        = "terraformstateaitdevops"  # Hardcoded container name for the state file
    key                   = "terraform.tfstate"  # Name of the state file

    # OIDC related values for backend
    subscription_id       = var.azure_subscription_id  # Azure Subscription ID for backend
    tenant_id             = var.azure_tenant_id  # Azure Tenant ID for backend
    client_id             = var.azure_client_id  # Azure Client ID for backend
  }
}

# Azure Provider block
provider "azurerm" {
  features {}

  # OIDC related values for provider
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
