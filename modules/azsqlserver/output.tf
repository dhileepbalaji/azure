output "id" {
  description = "The Microsoft SQL Server ID"
  value       = azurerm_sql_server.sqlserver.id
}

output "fqdn" {
  description = "The fully qualified domain name of the  Azure SQL Server" 
  value       = azurerm_sql_server.sqlserver.fully_qualified_domain_name
}

output "admin_user" {
  description = "SQL database administrator login id"
  value       = azurerm_sql_server.sqlserver.administrator_login
  sensitive   = true
}

output "admin_password" {
  description = "SQL database administrator login password"
  value       = azurerm_sql_server.sqlserver.administrator_login_password
  sensitive   = true
}


