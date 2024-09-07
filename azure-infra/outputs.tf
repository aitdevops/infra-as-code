# Output the resource group name
output "resource_group_name" {
  description = "The name of the resource group where the storage account is created."
  value       = azurerm_resource_group.rg.name
}
