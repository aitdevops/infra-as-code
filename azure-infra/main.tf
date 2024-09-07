# Backend configuration (hardcoded)
# Backend configuration (hardcoded)
terraform {
  backend "azurerm" {
    resource_group_name   = "aitdevops"  # Hardcoded resource group name for backend storage
    storage_account_name  = "terraformstateaitdevops"  # Hardcoded storage account name
    container_name        = "test"  # Updated container name to "test"
    key                   = "terraform.tfstate"  # Name of the state file

    # OIDC related values (hardcoded for backend)
    subscription_id       = "6e5394a9-f79c-4c60-9252-45d6d4a0f88c"  # Hardcoded subscription ID for backend
    tenant_id             = "4c470cc0-914e-41d8-b3f2-2812cb01d186"  # Hardcoded tenant ID for backend
    client_id             = "d385aa71-0f89-4204-964c-2cbb4322fcc0"  # Hardcoded client ID for backend
    use_oidc              = true  # Enable OIDC
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

# Resource Group block
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name  # Name of the resource group
  location = var.location  # Azure region where the resource group will be created
}
