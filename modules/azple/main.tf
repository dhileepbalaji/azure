locals {
    if_private_dns_zone_group_enabled = var.enable_private_dns_zone_group ? [{}] : []

}


resource "azurerm_private_endpoint" "ple" {
  name                 = var.ple_connection_name
  resource_group_name  = var.resource_group_name
  location             = var.location
  subnet_id            = var.subnet_id

  private_service_connection {
    name                           = var.ple_connection_name
    is_manual_connection           = var.is_manual_connection
    request_message                = var.request_message
    private_connection_resource_id = var.ple_source_id
    subresource_names              = var.ple_subresource_names
  }
}
