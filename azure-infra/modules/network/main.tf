resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_subnet" "private_subnet" {
  name                 = var.private_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.private_subnet_address_prefixes
}

resource "azurerm_nat_gateway" "nat_gateway" {
  name                = var.nat_gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_public_ip" "nat_gateway_ip" {
  name                = "${var.nat_gateway_name}-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_nat_gateway_public_ip_association" "nat_gateway_ip_association" {
  nat_gateway_id   = azurerm_nat_gateway.nat_gateway.id
  public_ip_address_ids = var.public_ip_address_ids
}

resource "azurerm_subnet_nat_gateway_association" "subnet_nat_gateway_association" {
  subnet_id     = azurerm_subnet.private_subnet.id
  nat_gateway_id = azurerm_nat_gateway.nat_gateway.id
}
