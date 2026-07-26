data "azurerm_public_ip" "fetch_pip" {
  for_each            = var.nat
  name                = each.value.public_ip_name
  resource_group_name = each.value.resource_group_name
}
data "azurerm_subnet" "fetch_subnet" {
  for_each             = var.nat_subnet_associations
  name                 = each.value.subnet_name
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name

}