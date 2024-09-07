terraform {
  backend "azurerm" {
    resource_group_name   = "aitdevops"
    storage_account_name  = "terraformstateaitdevops"
    container_name        = "terraformstateaitdevops"
    key                   = "terraform.tfstate"
    
    # Add Subscription ID, Tenant ID, and Client ID for OIDC authentication
    subscription_id       = "6e5394a9-f79c-4c60-9252-45d6d4a0f88c"  # Your subscription ID
    tenant_id             = "4c470cc0-914e-41d8-b3f2-2812cb01d186"  # Your tenant ID
    client_id             = "d385aa71-0f89-4204-964c-2cbb4322fcc0"  # Your client ID
    use_oidc              = true  # Enable OIDC authentication
  }
}
