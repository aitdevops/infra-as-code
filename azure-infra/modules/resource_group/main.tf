resource "azurerm_resource_group" "rg" {
  name     = var.rg_group_name
  location = var.location
}
