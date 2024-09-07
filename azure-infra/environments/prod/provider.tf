provider "azurerm" {
  features {}
  use_oidc        = true
  subscription_id = data.azurerm_key_vault_secret.azure_subscription_id.value
  tenant_id       = data.azurerm_key_vault_secret.azure_tenant_id.value
  client_id       = data.azurerm_key_vault_secret.azure_client_id.value
}

# Reference the existing Key Vault 'aitdevops-vault'
data "azurerm_key_vault" "existing" {
  name                = "aitdevops-vault"
  resource_group_name = "aitdevops"  # Adjust this to the correct resource group if needed
}

# Fetch secrets from the existing Key Vault
data "azurerm_key_vault_secret" "azure_subscription_id" {
  name         = "azure-subscription-id"
  key_vault_id = data.azurerm_key_vault.existing.id
}

data "azurerm_key_vault_secret" "azure_tenant_id" {
  name         = "azure-tenant-id"
  key_vault_id = data.azurerm_key_vault.existing.id
}

data "azurerm_key_vault_secret" "azure_client_id" {
  name         = "azure-client-id"
  key_vault_id = data.azurerm_key_vault.existing.id
}