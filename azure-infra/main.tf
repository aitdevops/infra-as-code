# Provider block: This configures the Azure provider to authenticate using OIDC.
provider "azurerm" {
  features {}
  use_oidc        = true  # Enables OIDC for authentication.
  subscription_id = var.azure_subscription_id  # Subscription where resources are created.
  tenant_id       = var.azure_tenant_id  # Azure Tenant ID.
  client_id       = var.azure_client_id  # Azure Client ID.
}

# Resource Group block: Creates a resource group to hold your storage account.
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name  # Name of the resource group.
  location = var.location  # Azure region for resource deployment.
}

# Storage Account block: Creates a storage account for storing the Terraform state file.
resource "azurerm_storage_account" "sa" {
  name                     = var.storage_account_name  # Name of the storage account.
  resource_group_name       = azurerm_resource_group.rg.name  # Resource group name where the account is created.
  location                  = azurerm_resource_group.rg.location  # Azure region of the storage account.
  account_tier              = "Standard"  # Specifies storage account performance tier (Standard or Premium).
  account_replication_type  = "LRS"  # Specifies replication type (LRS: Locally Redundant Storage).
}

# Storage Container block: Creates a container within the storage account to hold Terraform state files.
resource "azurerm_storage_container" "state_container" {
  name                  = var.container_name  # Name of the blob container.
  storage_account_name  = azurerm_storage_account.sa.name  # Reference to the storage account name.
  container_access_type = "private"  # Ensures the container is private and secure.
}

# Backend configuration: Configures the Terraform state to be stored in the newly created storage account and container.
terraform {
  backend "azurerm" {
    resource_group_name   = azurerm_resource_group.rg.name  # Resource group where the state storage is located.
    storage_account_name  = azurerm_storage_account.sa.name  # Storage account name for storing the state.
    container_name        = azurerm_storage_container.state_container.name  # Blob container name to store the state.
    key                   = "terraform.tfstate"  # The name of the state file stored in the container.
  }
}
