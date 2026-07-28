


data "azurerm_public_ip" "fetch_pip" {
  for_each            = var.lb
  name                = each.value.public_ip_name
  resource_group_name = each.value.resource_group_name
}


data "azurerm_network_interface" "fetch_nic" {
  for_each            = var.lb
  name                = each.value.network_interface_name
  resource_group_name = each.value.resource_group_name
}
