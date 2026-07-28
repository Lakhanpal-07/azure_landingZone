rgs = {
  rg_dev001 = {
    name     = "rg_dev001"
    location = "Central India"
  }
}

vnets = {
  vnet_dev001 = {
    name                = "vnet_dev001"
    location            = "Central India"
    resource_group_name = "rg_dev001"
    address_space       = ["10.123.0.0/16"]
  }
  vnet_dev002 = {
    name                = "vnet_dev002"
    location            = "Central India"
    resource_group_name = "rg_dev001"
    address_space       = ["10.124.0.0/16"]
  }
}

subnets = {
  frontend_subnet01 = {
    name                 = "frontend_subnet"
    virtual_network_name = "vnet_dev001"
    resource_group_name  = "rg_dev001"
    address_prefixes     = ["10.123.1.0/24"]
  }
  backend_subnet = {
    name                 = "backend_subnet"
    virtual_network_name = "vnet_dev001"
    resource_group_name  = "rg_dev001"
    address_prefixes     = ["10.123.2.0/24"]
  }
  AzureBastionSubnet = {
    name                 = "AzureBastionSubnet"
    virtual_network_name = "vnet_dev001"
    resource_group_name  = "rg_dev001"
    address_prefixes     = ["10.123.3.0/26"]
  }
  appgwSubnet = {
    name                 = "appgwSubnet"
    virtual_network_name = "vnet_dev001"
    resource_group_name  = "rg_dev001"
    address_prefixes     = ["10.123.4.0/24"]
  }
  frontend_subnet02 = {
    name                 = "frontend_subnet"
    virtual_network_name = "vnet_dev002"
    resource_group_name  = "rg_dev001"
    address_prefixes     = ["10.124.1.0/24"]
  }

}

pip = {
  Bastion_pip = {
    name                = "Bastion_pip"
    location            = "Central India"
    resource_group_name = "rg_dev001"
    allocation_method   = "Static"
    sku                 = "Standard"
  }
  #   frontendnic_pip = {
  #     name                = "frontendnic_pip"
  #     location            = "Central India"
  #     resource_group_name = "rg_dev001"
  #     allocation_method   = "Static"
  #     sku                 = "Standard"

  #   }
  #   backendnic_pip = {
  #     name                = "backendnic_pip"
  #     location            = "Central India"
  #     resource_group_name = "rg_dev001"
  #     allocation_method   = "Static"
  #     sku                 = "Standard"
  #   }
  nat_pip = {
    name                = "nat_pip"
    location            = "Central India"
    resource_group_name = "rg_dev001"
    allocation_method   = "Static"
    sku                 = "Standard"
  }
  lb_pip = {
    name                = "lb_pip"
    location            = "Central India"
    resource_group_name = "rg_dev001"
    allocation_method   = "Static"
    sku                 = "Standard"
  }
}

Bastion = {
  "Bastion_Host" = {
    name                  = "Bastion_Host"
    location              = "Central India"
    resource_group_name   = "rg_dev001"
    sku                   = "Standard"
    virtual_network_name  = "vnet_dev001"
    subnet_name           = "AzureBastionSubnet"
    public_ip_name        = "Bastion_pip"
    ip_configuration_name = "Bastion_configuration"
  }
}

nat = {
  nat_gateway = {
    name                    = "nat_gateway_vnet_dev001"
    location                = "Central India"
    resource_group_name     = "rg_dev001"
    sku_name                = "Standard"
    idle_timeout_in_minutes = 5
    public_ip_name          = "nat_pip"
  }
}
nat_subnet_associations = {
  frontend_associ = {
    subnet_name          = "frontend_subnet"
    virtual_network_name = "vnet_dev001"
    resource_group_name  = "rg_dev001"
    nat_key              = "nat_gateway"
  }
  backend_associ = {
    subnet_name          = "backend_subnet"
    virtual_network_name = "vnet_dev001"
    resource_group_name  = "rg_dev001"
    nat_key              = "nat_gateway"
  }
}

nic = {
  frontendnic = {
    name                 = "frontendnic"
    location             = "Central India"
    resource_group_name  = "rg_dev001"
    virtual_network_name = "vnet_dev001"
    subnet_name          = "frontend_subnet"
    # public_ip_name       = "frontendnic_pip"

    ip_configuration_name                          = "frontend_internal"
    ip_configuration_private_ip_address_allocation = "Dynamic"
  }
  backendnic = {
    name                 = "backendnic"
    location             = "Central India"
    resource_group_name  = "rg_dev001"
    virtual_network_name = "vnet_dev001"
    subnet_name          = "backend_subnet"
    # public_ip_name       = "backendnic_pip"

    ip_configuration_name                          = "backend_internal"
    ip_configuration_private_ip_address_allocation = "Dynamic"
  }
}

vm_linux = {
  vmlinuxfrontend = {
    name                            = "vmlinuxfrontend"
    location                        = "Central India"
    resource_group_name             = "rg_dev001"
    size                            = "Standard_B2ats_v2"
    admin_username                  = "Devops"
    admin_password                  = "devops@12345"
    disable_password_authentication = "false"
    nic_name                        = "frontendnic"
    os_disk_name                    = "frontend-osdisk"
    caching                         = "ReadWrite"
    storage_account_type            = "Standard_LRS"
    publisher                       = "debian"
    offer                           = "debian-12"
    sku                             = "12-gen2"
    version                         = "latest"
  }
  vmlinuxbackenend = {
    name                            = "vmlinuxbackendend"
    location                        = "Central India"
    resource_group_name             = "rg_dev001"
    size                            = "Standard_B2ats_v2"
    admin_username                  = "Devops"
    admin_password                  = "devops@12345"
    disable_password_authentication = "false"
    nic_name                        = "backendnic"
    os_disk_name                    = "backend-osdisk"
    caching                         = "ReadWrite"
    storage_account_type            = "Standard_LRS"
    publisher                       = "debian"
    offer                           = "debian-12"
    sku                             = "12-gen2"
    version                         = "latest"
  }
}


nsg_map = {
  nsg_frontend_dev = {
    name                 = "nsg_frontend_dev"
    location             = "Central India"
    resource_group_name  = "rg_dev001"
    subnet_name          = "frontend_subnet"
    virtual_network_name = "vnet_dev001"
    rules = [
      {
        name                       = "AllowHTTP"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        destination_port_range     = "80"
        source_port_range          = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "Allowssh"
        priority                   = 200
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        destination_port_range     = "22"
        source_port_range          = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }

  nsg_backend_dev = {
    name                 = "nsg_backend_dev"
    location             = "Central India"
    resource_group_name  = "rg_dev001"
    subnet_name          = "backend_subnet"
    virtual_network_name = "vnet_dev001"
    rules = [
      {
        name                       = "Allowssh"
        priority                   = 200
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        destination_port_range     = "22"
        source_port_range          = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
      {
        name                       = "AllowHTTP"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        destination_port_range     = "80"
        source_port_range          = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      }
    ]
  }

  nsg_admin_dev = {
    name                 = "nsg_admin_dev"
    location             = "Central India"
    resource_group_name  = "rg_dev001"
    subnet_name          = "frontend_subnet"
    virtual_network_name = "vnet_dev001"
    rules = [
      {
        name                       = "AllowSSH"
        priority                   = 300
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        destination_port_range     = "22"
        source_port_range          = "*"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
      },
    ]
  }
}


lb = {
  "dev-lb" = {
    name                                   = "external-lb"
    location                               = "Central India"
    resource_group_name                    = "rg_dev001"
    sku                                    = "Standard"
    frontend_ip_configuration_name         = "lb-frontend"
    backend_pool_name                      = "backend-pool"
    public_ip_name                         = "lb_pip"
    lb_probe_name                          = "http-probe"
    lb_probe_protocol                      = "Tcp"
    network_interface_name                 = "frontendnic"
    lb_probe_port                          = 80
    lb_rule_name                           = "http-rule"
    lb_rule_protocol                       = "Tcp"
    lb_rule_frontend_port                  = 80
    lb_rule_backend_port                   = 80
    lb_rule_frontend_ip_configuration_name = "lb-frontend"
    frontend_assoc_ip_configuration_name   = "frontend_internal"
    backend_assoc_ip_configuration_name    = "backend_internal"
  }
}
