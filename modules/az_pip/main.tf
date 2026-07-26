#  public ip address

variable "pip" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    allocation_method   = string
    sku                 = string

  }))
}

resource "azurerm_public_ip" "pip" {
  for_each            = var.pip
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = each.value.allocation_method
  sku                 = each.value.sku
}
