output "key_vault_ids" {
  description = "The IDs of the created Key Vault resources"
  value       = { for key, vault in azurerm_key_vault.kv : key => vault.id }
}

output "key_vault_names" {
  description = "The names of the created Key Vault resources"
  value       = { for key, vault in azurerm_key_vault.kv : key => vault.name }
}
