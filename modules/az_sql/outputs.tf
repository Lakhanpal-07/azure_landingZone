output "sql_server_ids" {
  description = "The IDs of the created SQL servers"
  value       = { for key, server in azurerm_mssql_server.sql_server : key => server.id }
}

output "sql_database_ids" {
  description = "The IDs of the created SQL databases"
  value       = { for key, db in azurerm_mssql_database.sql_database : key => db.id }
}
