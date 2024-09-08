module "resource_group" {
  source              = "../../modules/resource_group"
  rg_group_name       = var.rg_group_name
  location            = var.location
}
module "vnet" {
  source              = "../../modules/vnet"
  prefix              = "prod"
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
  address_prefixes    = ["10.0.0.0/24"]
}

resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = "${var.prefix}-rg"
}
