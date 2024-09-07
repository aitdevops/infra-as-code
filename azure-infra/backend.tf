terraform {
  backend "azurerm" {
    resource_group_name   = "aitdevops"
    storage_account_name  = "terraformstateaitdevops"
    container_name        = "terraformstateaitdevops"
    key                   = "terraform.tfstate"
    
    # Required for OIDC authentication
    tenant_id             = "4c470cc0-914e-41d8-b3f2-2812cb01d186"  # Your tenant ID
    client_id             = "d385aa71-0f89-4204-964c-2cbb4322fcc0"  # Your client ID
    use_oidc              = true  # Enable OIDC
  }
}
