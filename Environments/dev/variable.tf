variable "rgs" {
  type = map(object({
    name     = string
    location = string
  }))
}

variable "kv" {
  type = map(object({
    name                            = string
    location                        = string
    resource_group_name             = string
    sku_name                        = string
    tenant_id                       = optional(string)
    soft_delete_retention_days      = optional(number)
    purge_protection_enabled        = optional(bool)
    enabled_for_disk_encryption     = optional(bool)
    enabled_for_deployment          = optional(bool)
    enabled_for_template_deployment = optional(bool)
    public_network_access_enabled   = optional(bool)
    enable_rbac_authorization       = optional(bool)
  }))
  default = {
    keyvault_dev001 = {
      name                = "kv-dev001-jylu2026"
      location            = "Central India"
      resource_group_name = "rg_dev001"
      sku_name            = "standard"
    }
  }
}

variable "sql_servers" {
  type = map(object({
    name                          = string
    location                      = string
    resource_group_name           = string
    version                       = string
    administrator_login           = string
    administrator_login_password  = string
    minimum_tls_version           = optional(string)
    public_network_access_enabled = optional(bool)
  }))
  default = {
    sqlserver_dev001 = {
      name                          = "sqlsrv-dev001-jylu2026"
      location                      = "Central India"
      resource_group_name           = "rg_dev001"
      version                       = "12.0"
      administrator_login           = "sqladminuser"
      administrator_login_password  = "SqlAdmin123!"
      minimum_tls_version           = "1.2"
      public_network_access_enabled = true
    }
  }
}

variable "sql_databases" {
  type = map(object({
    name                        = string
    server_key                  = string
    resource_group_name         = string
    sku_name                    = string
    max_size_gb                 = optional(number)
    zone_redundant              = optional(bool)
    collation                   = optional(string)
    create_mode                 = optional(string)
    license_type                = optional(string)
    auto_pause_delay_in_minutes = optional(number)
  }))
  default = {
    sqldb_dev001 = {
      name                = "sqldb-dev001"
      server_key          = "sqlserver_dev001"
      resource_group_name = "rg_dev001"
      sku_name            = "Basic"
      max_size_gb         = 2
      collation           = "SQL_Latin1_General_CP1_CI_AS"
      create_mode         = "Default"
    }
  }
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

variable "lb" {
  type = map(object({
    name                                   = string
    location                               = string
    resource_group_name                    = string
    sku                                    = string
    frontend_ip_configuration_name         = string
    backend_pool_name                      = string
    public_ip_name                         = string
    lb_probe_name                          = string
    lb_probe_protocol                      = string
    network_interface_name                 = string
    lb_probe_port                          = number
    lb_rule_name                           = string
    lb_rule_protocol                       = string
    lb_rule_frontend_port                  = number
    lb_rule_backend_port                   = number
    lb_rule_frontend_ip_configuration_name = string
    frontend_nic_key                       = string
    backend_nic_key                        = string
    frontend_assoc_ip_configuration_name   = string
    backend_assoc_ip_configuration_name    = string
  }))
}

# variable "appgw" {
#   type = map(object({
#     name                           = string
#     location                       = string
#     resource_group_name            = string
#     sku_name                       = string
#     sku_tier                       = string
#     sku_capacity                   = number
#     gateway_ip_configuration_name  = string
#     virtual_network_name           = string
#     subnet_name                    = string
#     frontend_port_name             = string
#     frontend_port                  = number
#     frontend_ip_configuration_name = string
#     public_ip_name                 = string
#     backend_address_pool_name      = string
#     backend_ip_addresses           = list(string)
#     backend_http_settings_name     = string
#     cookie_based_affinity          = string
#     http_settings_port             = number
#     http_settings_protocol         = string
#     request_timeout                = number
#     http_listener_name             = string
#     listener_protocol              = string
#     request_routing_rule_name      = string
#     rule_type                      = string
#     priority                       = number
#   }))
# }

