


data "azurerm_public_ip" "fetch_pip" {
  for_each            = var.lb
  name                = each.value.public_ip_name
  resource_group_name = each.value.resource_group_name
}


data "azurerm_network_interface" "fetch_nic" {
  for_each = merge(
    {
      for lb_key, lb_value in var.lb :
      "${lb_key}_frontend" => {
        name                = lb_value.frontend_nic_key
        resource_group_name = lb_value.resource_group_name
      }
    },
    {
      for lb_key, lb_value in var.lb :
      "${lb_key}_backend" => {
        name                = lb_value.backend_nic_key
        resource_group_name = lb_value.resource_group_name
      }
    }
  )

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
}
