terraform {
  backend "azurerm" {
    resource_group_name   = "aitdevops"                    # Name of the Resource Group
    storage_account_name  = "terraformstateaitdevops"      # Storage Account for the state
    container_name        = "terraformstateaitdevops"      # Container for the state
    key                   = "terraform.tfstate"            # Name of the state file
    subscription_id       = var.subscription_id            # Optional: Ensure the right subscription is used
  }
}
