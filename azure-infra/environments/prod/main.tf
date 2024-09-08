module "resource_group" {
  source              = "../../modules/resource_group"
  rg_group_name       = var.rg_group_name
  location            = var.location
}
module "network" {
  source                  = "../../modules/network"
  vnet_name               = var.vnet_name
  address_space           = ["10.0.0.0/16"]
  location                = var.location
  resource_group_name     =  var.resource_group_name
  tags                    = { "Environment" = "Production" }
  private_subnet_name     = var.private_subnet_name
  private_subnet_address_prefixes = ["10.0.1.0/24"]
  nat_gateway_name        = var.nat_gateway_name 
  public_ip_address_ids    = [azurerm_public_ip.my_public_ip.id]  # Defin and create this resource in your configuration
}
