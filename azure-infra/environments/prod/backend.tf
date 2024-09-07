terraform {
  backend "azurerm" {
    resource_group_name   = var.backend_resource_group_name
    storage_account_name  = var.backend_storage_account_name
    container_name        = var.backend_container_name
    key                   = var.backend_key
    use_oidc              = true
    subscription_id       = var.azure_subscription_id
    tenant_id             = var.azure_tenant_id
    client_id             = var.azure_client_id
  }
}
