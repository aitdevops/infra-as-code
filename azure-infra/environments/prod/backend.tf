terraform {
  backend "azurerm" {
    resource_group_name   = "aitdevops"
    storage_account_name  = "terraformstateaitdevops"
    container_name        = "terraformstateaitdevops"
    key                   = "terraform.tfstate"
    # No subscription_id here, will be provided via environment variable
  }
}
