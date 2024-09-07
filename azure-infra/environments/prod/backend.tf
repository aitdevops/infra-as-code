# Backend configuration for storing Terraform state in Azure Blob Storage
terraform {
  backend "azurerm" {
    resource_group_name   = "aitdevops"
    storage_account_name  = "terraformstateaitdevops"
    container_name        = "aitdevops"
    key                   = "terraform.tfstate"
    subscription_id       = data.azurerm_key_vault_secret.azure_subscription_id.value
    tenant_id             = data.azurerm_key_vault_secret.azure_tenant_id.value
    client_id             = data.azurerm_key_vault_secret.azure_client_id.value
    use_oidc              = true
  }
}
