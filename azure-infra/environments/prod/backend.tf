terraform {
  backend "azurerm" {
    resource_group_name   = "aitdevops"
    storage_account_name  = "terraformstateaitdevops"
    container_name        = "aitdevops"
    key                   = "terraform.tfstate"
    use_oidc              = true
  }
}
