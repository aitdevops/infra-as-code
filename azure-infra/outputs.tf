# Output the storage account name
output "storage_account_name" {
  description = "The name of the created storage account for storing the Terraform state."
  value       = azurerm_storage_account.sa.name
}

# Output the storage container name
output "storage_container_name" {
  description = "The name of the created blob container to store Terraform state."
  value       = azurerm_storage_container.state_container.name
}

# Output the resource group name
output "resource_group_name" {
  description = "The name of the resource group where the storage account is created."
  value       = azurerm_resource_group.rg.name
}
