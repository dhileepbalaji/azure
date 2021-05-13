# Output the resource id of the private endpoint
output "ple_id" {
  value = azurerm_private_endpoint.ple.id
}
