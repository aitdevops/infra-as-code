terraform {
  backend "azurerm" {
    resource_group_name   = "aitdevops"
    storage_account_name  = "terraformstateaitdevops"
    container_name        = "terraformstateaitdevops"
    key                   = "terraform.tfstate" # The name of the state file
  }
}
