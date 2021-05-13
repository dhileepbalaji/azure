output "name" {
  value = azurerm_storage_account.storageaccount.name
}

output "id" {
  value = azurerm_storage_account.storageaccount.id
}

output "primary_access_key" {
  value = azurerm_storage_account.storageaccount.primary_access_key
}

output "primary_blob_endpoint" {
  value = azurerm_storage_account.storageaccount.primary_blob_endpoint
}

output "primary_connection_string" {
  value = azurerm_storage_account.storageaccount.primary_connection_string
}