provider "azurerm" {
  features = {}

  # Use these environment variables set by GitHub Actions
  client_id       = var.client_id       # Azure Client ID
  tenant_id       = var.tenant_id       # Azure Tenant ID
  subscription_id = var.subscription_id # Azure Subscription ID

  use_oidc = true  # Tells Terraform to use OIDC for authentication
}
