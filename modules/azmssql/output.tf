output "sql_database_id" {
  description = "The SQL Database ID"
  value       = azurerm_mssql_database.database.id
}

output "sql_database_name" {
  description = "The SQL Database Name"
  value       = azurerm_mssql_database.database.name
}

