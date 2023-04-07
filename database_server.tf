# Generate random value for the name
resource "random_string" "name" {
  length  = 8
  lower   = true
  numeric = false
  special = false
  upper   = false
}

# Generate random value for the login password
resource "random_password" "password" {
  length           = 32
  lower            = true
  min_lower        = 3
  min_numeric      = 3
  min_special      = 3
  min_upper        = 3
  numeric          = true
  override_special = "_"
  special          = true
  upper            = true
}

# Enables you to manage Private DNS zones within Azure DNS
resource "azurerm_private_dns_zone" "default" {
  name                = "${random_string.name.result}.mysql.database.azure.com"
  resource_group_name = azurerm_resource_group.rg.name
}

# Enables you to manage Private DNS zone Virtual Network Links
resource "azurerm_private_dns_zone_virtual_network_link" "default" {
  name                  = "${var.project_name_prefix}vnetzone${random_string.name.result}.com"
  private_dns_zone_name = azurerm_private_dns_zone.default.name
  resource_group_name   = azurerm_resource_group.rg.name
  virtual_network_id    = azurerm_virtual_network.vnet.id
}

# Manages the MySQL Flexible Server
resource "azurerm_mysql_flexible_server" "db" {
  location                     = azurerm_resource_group.rg.location
  name                         = "${var.project_name_prefix}dbserver${random_string.name.result}"
  resource_group_name          = azurerm_resource_group.rg.name
  administrator_login          = random_string.name.result
  administrator_password       = random_password.password.result
  backup_retention_days        = 7
  delegated_subnet_id          = azurerm_subnet.dbsubnet.id
  geo_redundant_backup_enabled = false
  private_dns_zone_id          = azurerm_private_dns_zone.default.id
  sku_name                     = "B_Standard_B1s"
  version                      = "8.0.21"
  zone                         = "1"

  maintenance_window {
    day_of_week  = 0
    start_hour   = 8
    start_minute = 0
  }
  storage {
    iops    = 360
    size_gb = 20
  }

  depends_on = [azurerm_private_dns_zone_virtual_network_link.default]
}

# Sets server parameter
resource "azurerm_mysql_flexible_server_configuration" "transaction_isolation" {
  name                = "transaction_isolation"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_flexible_server.db.name
  value               = "READ-COMMITTED"
}

# Sets server parameter
resource "azurerm_mysql_flexible_server_configuration" "require_secure_transport" {
  name                = "require_secure_transport"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_flexible_server.db.name
  value               = "OFF"
}