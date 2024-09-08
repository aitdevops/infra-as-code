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
  vnet_name                 = "my-vnet"
  address_space             = ["10.0.0.0/16"]
  location                  = var.location
  resource_group_name       = var.resource_group_name
  tags                      = { "Environment" = "Production" }
  private_subnet_name       = "my-private-subnet"
  private_subnet_address_prefixes = ["10.0.1.0/24"]
  nat_gateway_name          = "my-nat-gateway"
  public_ip_address_id      = azurerm_public_ip.nat_gateway_ip.id
}



