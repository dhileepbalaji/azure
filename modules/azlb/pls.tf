resource "azurerm_private_link_service" "pls" {
  count                                       = var.enable_pls ? 1 : 0
  name                                        = var.pls_name
  resource_group_name                         = var.resource_group_name
  location                                    = var.location
  auto_approval_subscription_ids              = var.auto_approval_subscription_ids
  visibility_subscription_ids                 = var.visibility_subscription_ids
  load_balancer_frontend_ip_configuration_ids = [azurerm_lb.azlb.frontend_ip_configuration.0.id]

  nat_ip_configuration {
    name                       = "primary"
    private_ip_address         = var.private_ip_address
    private_ip_address_version = "IPv4"
    subnet_id                  = var.subnet_id
    primary                    = true
  }
}