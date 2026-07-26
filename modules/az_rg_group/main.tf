# resource_group

variable "rgs" {
  type = map(object({
    name     = string
    location = string
  }))
}


resource "azurerm_resource_group" "rgs" {
  for_each = var.rgs
  name     = each.value.name
  location = each.value.location
}
