terraform {
  backend "azurerm" {
    resource_group_name   = "aitdevops"
    storage_account_name  = "terraformstateaitdevops"
    container_name        = "aitdevops"
    key                   = "terraform.tfstate"
    subscription_id       = var.subscription_id  # Pull from environment variable or explicit variable
    tenant_id             = var.tenant_id        # Pull from environment variable or explicit variable
    client_id             = var.client_id        # Pull from environment variable or explicit variable
    use_oidc              = true
  }
}
