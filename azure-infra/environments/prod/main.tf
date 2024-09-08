module "resource_group" {
  source              = "../../modules/resource_group"
  rg_group_name       = var.rg_group_name
  location            = var.location
}
resource "azurerm_public_ip" "nat_gateway_ip" {
  name                = "my-nat-gateway-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

module "network" {
  source                    = "../../modules/network"
  vnet_name                 = var.vnet_name
  address_space             = var.address_space
  location                  = var.location
  resource_group_name       = var.resource_group_name
  tags                      = var.tags
  private_subnet_name       = var.private_subnet_name 
  private_subnet_address_prefixes = var.private_subnet_address_prefixes
  nat_gateway_name          = var.nat_gateway_name
  public_ip_address_id      = azurerm_public_ip.nat_gateway_ip.id
}



