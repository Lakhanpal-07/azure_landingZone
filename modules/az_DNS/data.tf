data "azurerm_public_ip" "fetch_pip" {
  for_each            = { for k, v in var.dns_a_records : k => v if v.public_ip_name != null }
  name                = each.value.public_ip_name
  resource_group_name = each.value.resource_group_name
}
