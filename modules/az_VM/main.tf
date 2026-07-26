variable "vm_linux" {
  type = map(object({
    name                            = string
    location                        = string
    resource_group_name             = string
    size                            = string
    admin_username                  = string
    admin_password                  = string
    disable_password_authentication = bool
    nic_name                        = string
    os_disk_name                    = string
    caching                         = string
    storage_account_type            = string
    publisher                       = string
    offer                           = string
    sku                             = string
    version                         = string
  }))
}

data "azurerm_network_interface" "nic" {
  for_each            = var.vm_linux
  name                = each.value.nic_name
  resource_group_name = each.value.resource_group_name
}

resource "azurerm_linux_virtual_machine" "vm_linux" {
  for_each                        = var.vm_linux
  name                            = each.value.name
  resource_group_name             = each.value.resource_group_name
  location                        = each.value.location
  size                            = each.value.size
  admin_username                  = each.value.admin_username
  admin_password                  = each.value.admin_password
  disable_password_authentication = false
  network_interface_ids           = [data.azurerm_network_interface.nic[each.key].id]

  # admin_ssh_key {
  #   username   = each.value.admin_username
  #   public_key = each.value.public_key
  # }

  os_disk {
    name                 = each.value.os_disk_name
    caching              = each.value.caching
    storage_account_type = each.value.storage_account_type
  }

  source_image_reference {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
    version   = each.value.version
  }
}
