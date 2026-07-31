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
  default = {}
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
  default = {}
}

resource "azurerm_mssql_server" "sql_server" {
  for_each = var.sql_servers

  name                          = each.value.name
  resource_group_name           = each.value.resource_group_name
  location                      = each.value.location
  version                       = each.value.version
  administrator_login           = each.value.administrator_login
  administrator_login_password  = each.value.administrator_login_password
  minimum_tls_version           = each.value.minimum_tls_version != null ? each.value.minimum_tls_version : "1.2"
  public_network_access_enabled = each.value.public_network_access_enabled != null ? each.value.public_network_access_enabled : true
}

resource "azurerm_mssql_database" "sql_database" {
  for_each = var.sql_databases

  name                        = each.value.name
  server_id                   = azurerm_mssql_server.sql_server[each.value.server_key].id
  sku_name                    = each.value.sku_name
  max_size_gb                 = each.value.max_size_gb != null ? each.value.max_size_gb : 32
  zone_redundant              = each.value.zone_redundant != null ? each.value.zone_redundant : false
  collation                   = each.value.collation != null ? each.value.collation : "SQL_Latin1_General_CP1_CI_AS"
  create_mode                 = each.value.create_mode != null ? each.value.create_mode : "Default"
  auto_pause_delay_in_minutes = each.value.auto_pause_delay_in_minutes
  license_type                = each.value.license_type
}
