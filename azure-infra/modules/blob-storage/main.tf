# provider "azurerm" {
#   features = {}
# }

# # Resource Group
# resource "azurerm_resource_group" "rg" {
#   name     = "rg-terraform-backend"
#   location = "East US"
# }

# # Storage Account
# resource "azurerm_storage_account" "sa" {
#   name                     = "terraformbackendstore" # Must be globally unique
#   resource_group_name       = azurerm_resource_group.rg.name
#   location                  = azurerm_resource_group.rg.location
#   account_tier              = "Standard"
#   account_replication_type  = "LRS"
# }

# # Storage Container for Terraform State Files
# resource "azurerm_storage_container" "terraform_state" {
#   name                  = "aitdevops-tfstate"
#   storage_account_name  = azurerm_storage_account.sa.name
#   container_access_type = "private"
# }

# # Storage Account Access Key (for backend configuration)
# output "storage_account_access_key" {
#   value = azurerm_storage_account.sa.primary_access_key
#   sensitive = true
# }
