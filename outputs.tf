output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "public_ip_address" {
  value = azurerm_linux_virtual_machine.vm01.public_ip_address
}

output "tls_private_key" {
  value     = tls_private_key.example_ssh.private_key_pem
  sensitive = true
}

output "azurerm_mysql_flexible_server" {
  value = azurerm_mysql_flexible_server.db.name
}

output "admin_login" {
  value = azurerm_mysql_flexible_server.db.administrator_login
}

output "admin_password" {
  sensitive = true
  value     = azurerm_mysql_flexible_server.db.administrator_password
}

output "mysql_flexible_server_database_name" {
  value = azurerm_mysql_flexible_database.tsg_drupal.name
}