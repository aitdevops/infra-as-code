provider "azurerm" {
  features {}
  use_oidc        = true
  subscription_id = var.azure_subscription_id  # Use GitHub Secret passed via environment variable
  tenant_id       = var.azure_tenant_id        # UseGitHub Secret passed via environment variable
  client_id       = var.azure_client_id        # Use GitHub Secret passed via environment variable
}
