data "azurerm_subnet" "fetch_subnet" {
  for_each             = var.Bastion
  name                 = each.value.subnet_name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name

}

data "azurerm_public_ip" "fetch_pip" {
  for_each            = var.Bastion
  name                = each.value.public_ip_name
  resource_group_name = each.value.resource_group_name
}
