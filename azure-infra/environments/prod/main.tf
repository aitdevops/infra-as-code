module "vnet" {
  source              = "../../modules/vnet"
  prefix              = var.prefix
  location            = var.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = var.address_space
  address_prefixes    = var.address_prefixes
}

resource "azurerm_resource_group" "rg" {
  location = var.location
  name     = "${var.prefix}-rg"
}
module "aks" {
  source              = "../../modules/aks"
  prefix              = var.prefix
  location            = var.location
  resource_group_name = var.resource_group_name
  node_count = var.node_count
  vm_size    = var.vm_size
}
