
variable "lb" {
  type = map(object({
    name                                   = string
    location                               = string
    resource_group_name                    = string
    sku                                    = string
    frontend_ip_configuration_name         = string
    backend_pool_name                      = string
    public_ip_name                         = string
    lb_probe_name                          = string
    lb_probe_protocol                      = string
    network_interface_name                 = string
    lb_probe_port                          = number
    lb_rule_name                           = string
    lb_rule_protocol                       = string
    lb_rule_frontend_port                  = number
    lb_rule_backend_port                   = number
    lb_rule_frontend_ip_configuration_name = string
    frontend_assoc_ip_configuration_name   = string
    backend_assoc_ip_configuration_name    = string

  }))
}

#  Load Balancer
resource "azurerm_lb" "external_lb" {
  for_each            = var.lb
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = each.value.sku

  frontend_ip_configuration {
    name                 = each.value.frontend_ip_configuration_name
    public_ip_address_id = data.azurerm_public_ip.fetch_pip[each.key].id
  }
}
# Backend Pool
resource "azurerm_lb_backend_address_pool" "backend_pool" {
  for_each        = var.lb
  name            = each.value.backend_pool_name
  loadbalancer_id = azurerm_lb.external_lb[each.key].id
}

# Health Probe
resource "azurerm_lb_probe" "http_probe" {
  for_each        = var.lb
  name            = each.value.lb_probe_name
  loadbalancer_id = azurerm_lb.external_lb[each.key].id
  protocol        = each.value.lb_probe_protocol
  port            = each.value.lb_probe_port
}

# Load Balancer Rule
resource "azurerm_lb_rule" "http_rule" {
  for_each                       = var.lb
  name                           = each.value.lb_rule_name
  loadbalancer_id                = azurerm_lb.external_lb[each.key].id
  protocol                       = each.value.lb_rule_protocol
  frontend_port                  = each.value.lb_rule_frontend_port
  backend_port                   = each.value.lb_rule_backend_port
  frontend_ip_configuration_name = each.value.lb_rule_frontend_ip_configuration_name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backend_pool[each.key].id]
  probe_id                       = azurerm_lb_probe.http_probe[each.key].id
}

resource "azurerm_network_interface_backend_address_pool_association" "frontend_assoc" {
  for_each                = var.lb
  network_interface_id    = data.azurerm_network_interface.fetch_nic[each.key].id
  ip_configuration_name   = each.value.frontend_assoc_ip_configuration_name
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool[each.key].id
}

resource "azurerm_network_interface_backend_address_pool_association" "backend_assoc" {
  for_each                = var.lb
  network_interface_id    = data.azurerm_network_interface.fetch_nic[each.key].id
  ip_configuration_name   = each.value.backend_assoc_ip_configuration_name
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool[each.key].id
}

