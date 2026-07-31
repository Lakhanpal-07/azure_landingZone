data "azurerm_client_config" "current" {}

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
    rbac_authorization_enabled      = optional(bool)
  }))
}

resource "azurerm_key_vault" "kv" {
  for_each = var.kv

  name                            = each.value.name
  location                        = each.value.location
  resource_group_name             = each.value.resource_group_name
  tenant_id                       = each.value.tenant_id != null ? each.value.tenant_id : data.azurerm_client_config.current.tenant_id
  sku_name                        = each.value.sku_name
  soft_delete_retention_days      = each.value.soft_delete_retention_days != null ? each.value.soft_delete_retention_days : 90
  purge_protection_enabled        = each.value.purge_protection_enabled != null ? each.value.purge_protection_enabled : false
  enabled_for_disk_encryption     = each.value.enabled_for_disk_encryption != null ? each.value.enabled_for_disk_encryption : true
  enabled_for_deployment          = each.value.enabled_for_deployment != null ? each.value.enabled_for_deployment : false
  enabled_for_template_deployment = each.value.enabled_for_template_deployment != null ? each.value.enabled_for_template_deployment : false
  public_network_access_enabled   = each.value.public_network_access_enabled != null ? each.value.public_network_access_enabled : true
  rbac_authorization_enabled      = each.value.rbac_authorization_enabled != null ? each.value.rbac_authorization_enabled : true
}
