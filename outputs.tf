output "container_group_ip_address" {
  value = azurerm_container_group.mudkip.ip_address
}

output "postgresql_server_connection_string" {
  value = "postgres://${azurerm_postgresql_server.mudkip.administrator_login}@${azurerm_postgresql_server.mudkip.name}:xxxxxxxx@${azurerm_postgresql_server.mudkip.fqdn}:5432/${azurerm_postgresql_database.mudkip.name}?sslmode=require"
}
