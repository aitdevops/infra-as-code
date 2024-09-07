terraform {
  backend "azurerm" {
    resource_group_name   = "aitdevops"
    storage_account_name  = "terraformstateaitdevops"
    container_name        = "terraformstateaitdevops"
    key                   = "terraform.tfstate"

    # Add these to enable OIDC authentication for the backend
    use_oidc = true  # Enable OIDC
  }
}
