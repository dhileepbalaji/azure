resource "azurerm_public_ip" "azlb" {
  count               = var.type == "public" ? 1 : 0
  name                = "${var.name}-publicIP"
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = var.allocation_method
  sku                 = var.pip_sku
  tags                = var.tags
}

resource "azurerm_lb" "azlb" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.lb_sku
  tags                = var.tags

  frontend_ip_configuration {
    name                          = var.frontend_name
    public_ip_address_id          = var.type == "public" ? join("", azurerm_public_ip.azlb.*.id) : ""
    subnet_id                     = var.frontend_subnet_id
    private_ip_address            = var.frontend_private_ip_address
    private_ip_address_allocation = var.frontend_private_ip_address_allocation
  }
}

resource "azurerm_lb_backend_address_pool" "azlb" {
  name                = "BackEndAddressPool"
  resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.azlb.id
}

resource "azurerm_lb_nat_rule" "azlb" {
  count                          = length(var.nat_rule)
  name                           = element(keys(var.nat_rule), count.index)
  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.azlb.id
  frontend_port                  = element(var.nat_rule[element(keys(var.nat_rule), count.index)], 0)
  protocol                       = element(var.nat_rule[element(keys(var.nat_rule), count.index)], 1)
  backend_port                   = element(var.nat_rule[element(keys(var.nat_rule), count.index)], 2)
  frontend_ip_configuration_name = var.frontend_name
}

resource "azurerm_lb_probe" "azlb" {
  count               = length(var.lb_probe)
  name                = element(keys(var.lb_probe), count.index)
  resource_group_name = var.resource_group_name
  loadbalancer_id     = azurerm_lb.azlb.id
  port                = element(var.lb_probe[element(keys(var.lb_probe), count.index)], 0)
  protocol            = element(var.lb_probe[element(keys(var.lb_probe), count.index)], 1)
  interval_in_seconds = var.lb_probe_interval
  number_of_probes    = var.lb_probe_unhealthy_threshold
  request_path        = element(var.lb_probe[element(keys(var.lb_probe), count.index)], 2)
}

resource "azurerm_lb_rule" "azlb" {
  count                          = length(var.lb_rule)
  name                           = element(keys(var.lb_rule), count.index)
  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.azlb.id
  frontend_port                  = element(var.lb_rule[element(keys(var.lb_rule), count.index)], 0)
  protocol                       = element(var.lb_rule[element(keys(var.lb_rule), count.index)], 1)
  backend_port                   = element(var.lb_rule[element(keys(var.lb_rule), count.index)], 2)
  frontend_ip_configuration_name = var.frontend_name
  enable_floating_ip             = false
  backend_address_pool_id        = azurerm_lb_backend_address_pool.azlb.id
  idle_timeout_in_minutes        = 5
  probe_id                       = element(azurerm_lb_probe.azlb.*.id, count.index)
}

resource "azurerm_lb_outbound_rule" "azoutbound" {
  count                   = var.type == "public" ? 1 : 0
  resource_group_name     = var.resource_group_name
  loadbalancer_id         = azurerm_lb.azlb.id
  name                    = "OutboundRule"
  protocol                = "Tcp"
  backend_address_pool_id = azurerm_lb_backend_address_pool.azlb.id

  frontend_ip_configuration {
    name = var.frontend_name
  }
}