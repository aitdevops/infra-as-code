# Backend configuration for storing Terraform state in Azure Blob Storage (hardcoded values for OIDC authentication)
terraform {
  backend "azurerm" {
    resource_group_name   = "aitdevops"  # Name of the resource group for backend storage
    storage_account_name  = "terraformstateaitdevops"  # Storage account name for backend
    container_name        = "test"  # Updated container name to "test"
    key                   = "terraform.tfstate"  # The name of the state file in Azure Blob Storage

    # OIDC-related values for backend authentication
    subscription_id       = "6e5394a9-f79c-4c60-9252-45d6d4a0f88c"  # Hardcoded Subscription ID for backend
    tenant_id             = "4c470cc0-914e-41d8-b3f2-2812cb01d186"  # Hardcoded Tenant ID for backend
    client_id             = "d385aa71-0f89-4204-964c-2cbb4322fcc0"  # Hardcoded Client ID for backend
    use_oidc              = true  # Enable OIDC authentication for the backend
  }
}

# AzureRM Provider configuration using OIDC or authentication
provider "azurerm" {
  features {}

  # OIDC-related values for provider authentication (using variables)
  use_oidc        = true  # Enable OIDC for provider
  subscription_id = var.azure_subscription_id  # Azure Subscription ID for provider
  tenant_id       = var.azure_tenant_id  # Azure Tenant ID for provider
  client_id       = var.azure_client_id  # Azure Client ID for provider
}

# Azure Resource Group creation
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name  # The name of the resource group
  location = var.location  # The Azure region where the resource group will be created
}
