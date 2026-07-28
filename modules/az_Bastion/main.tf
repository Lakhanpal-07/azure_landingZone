variable "Bastion" {
  type = map(object({
    name                  = string
    location              = string
    resource_group_name   = string
    sku                   = string
    virtual_network_name  = string
    subnet_name           = string
    public_ip_name        = string
    ip_configuration_name = string

  }))

}

resource "azurerm_bastion_host" "Bastion" {
  for_each            = var.Bastion
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  sku                 = each.value.sku

  ip_configuration {
    name                 = each.value.ip_configuration_name
    subnet_id            = data.azurerm_subnet.fetch_subnet[each.key].id
    public_ip_address_id = data.azurerm_public_ip.fetch_pip[each.key].id
  }
}
