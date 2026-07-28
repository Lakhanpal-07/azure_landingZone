
data "azurerm_subnet" "fetch_subnet" {
  for_each             = var.nsg
  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}


#  will be usefull when create dhere and recalled in another module 

# data "azurerm_network_security_group" "fetch-nsg" {
#   for_each = var.nsg
#   name                = each.value.network_security_group                
#   resource_group_name = each.value.resource_group_name
# }