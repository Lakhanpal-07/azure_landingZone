variable "nat" {
  type = map(object({
    name                    = string
    location                = string
    resource_group_name     = string
    sku_name                = string
    idle_timeout_in_minutes = number
    public_ip_name          = string
  }))
}
variable "nat_subnet_associations" {
  type = map(object({
    subnet_name          = string
    virtual_network_name = string
    resource_group_name  = string
    nat_key              = string
  }))
}


resource "azurerm_nat_gateway" "nat" {
  for_each                = var.nat
  name                    = each.value.name
  location                = each.value.location
  resource_group_name     = each.value.resource_group_name
  sku_name                = each.value.sku_name
  idle_timeout_in_minutes = each.value.idle_timeout_in_minutes
}

resource "azurerm_nat_gateway_public_ip_association" "fetch_pip" {
  for_each             = var.nat
  nat_gateway_id       = azurerm_nat_gateway.nat[each.key].id
  public_ip_address_id = data.azurerm_public_ip.fetch_pip[each.key].id
}

resource "azurerm_subnet_nat_gateway_association" "nat_subnet_assoc" {
  for_each       = var.nat_subnet_associations
  subnet_id      = data.azurerm_subnet.fetch_subnet[each.key].id
  nat_gateway_id = azurerm_nat_gateway.nat[each.value.nat_key].id
}
