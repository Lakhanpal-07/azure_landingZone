# network security group 

variable "nsg" {
  type = map(object({
    name                 = string
    location             = string
    resource_group_name  = string
    subnet_name          = string
    virtual_network_name = string
    rules = list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      destination_port_range     = string
      source_port_range          = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))
  }))
}



resource "azurerm_network_security_group" "nsg" {
  for_each            = var.nsg
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  dynamic "security_rule" {
    for_each = each.value.rules
    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      destination_port_range     = security_rule.value.destination_port_range
      source_port_range          = security_rule.value.source_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix
    }
  }
}


resource "azurerm_subnet_network_security_group_association" "nsg_assoc" {
  for_each                  = var.nsg
  subnet_id                 = data.azurerm_subnet.fetch_subnet[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}
