# Network Interface Card

variable "nic" {
  type = map(object({
    name                 = string
    location             = string
    resource_group_name  = string
    virtual_network_name = string
    subnet_name          = string

    ip_configuration_name                          = string
    ip_configuration_private_ip_address_allocation = string

  }))
}



resource "azurerm_network_interface" "nic" {
  for_each            = var.nic
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name      = each.value.ip_configuration_name
    subnet_id = data.azurerm_subnet.fetch_subnet[each.key].id
    # public_ip_address_id          = data.azurerm_public_ip.fetch_pip[each.key].id
    private_ip_address_allocation = each.value.ip_configuration_private_ip_address_allocation
  }
}
