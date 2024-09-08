output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}

output "private_subnet_id" {
  value = azurerm_subnet.private_subnet.id
}

output "nat_gateway_id" {
  value = azurerm_nat_gateway.nat_gateway.id
}