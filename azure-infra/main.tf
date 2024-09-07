# Provider block: This configures the Azure provider to authenticate using OIDC.
provider "azurerm" {
  features {}
  use_oidc        = true
  subscription_id = var.azure_subscription_id
  tenant_id       = var.azure_tenant_id
  client_id       = var.azure_client_id
}

# Resource Group block: Creates a resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

# Storage Account block: Creates a storage account
resource "azurerm_storage_account" "sa" {
  name                     = var.storage_account_name
  resource_group_name       = azurerm_resource_group.rg.name
  location                  = azurerm_resource_group.rg.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
}

# Storage Container block: Creates a container for the state file
resource "azurerm_storage_container" "state_container" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}


# Backend configuration: Configures the Terraform state to be stored in the newly created storage account and container.
terraform {
  backend "azurerm" {
    resource_group_name   = var.backend_resource_group_name  # Use variable for resource group name
    storage_account_name  = var.backend_storage_account_name  # Use variable for storage account name
    container_name        = var.backend_container_name  # Use variable for container name
    key                   = "terraform.tfstate"  # State file name
  }
}

