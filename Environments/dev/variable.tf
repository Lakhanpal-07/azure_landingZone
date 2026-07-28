variable "rgs" {
  type = map(object({
    name     = string
    location = string
  }))
}

variable "vnets" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    address_space       = list(string)
  }))
}

variable "subnets" {
  type = map(object({
    name                 = string
    virtual_network_name = string
    resource_group_name  = string
    address_prefixes     = list(string)
  }))
}

variable "pip" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    allocation_method   = string
    sku                 = string

  }))
}

variable "Bastion" {
  type = map(object({
    name                  = string
    location              = string
    resource_group_name   = string
    sku                   = string
    virtual_network_name  = string
    subnet_name           = string
    public_ip_name        = string
    ip_configuration_name = string

  }))

}

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


variable "nic" {
  type = map(object({
    name                 = string
    location             = string
    resource_group_name  = string
    virtual_network_name = string
    subnet_name          = string

    ip_configuration_name                          = string
    ip_configuration_private_ip_address_allocation = string

  }))
}

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

# variable "nsg_map" {
#   type = map(any)
# }

variable "nsg_map" {
  type = map(object({
    name                 = string
    location             = string
    resource_group_name  = string
    subnet_name          = string
    virtual_network_name = string
    rules = list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      destination_port_range     = string
      source_port_range          = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))
  }))
}