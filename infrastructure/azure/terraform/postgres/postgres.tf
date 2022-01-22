# base postgres
resource "azurerm_postgresql_server" "postgres" {
  name                     = "${var.environment}-postgres"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  sku_name = "B_Gen5_1"
  storage_mb                   = 5120
  backup_retention_days        = 7
  geo_redundant_backup_enabled = false
  auto_grow_enabled            = true
  administrator_login          = var.postgres_admin
  administrator_login_password = var.postgres_password
  version                      = "11"
  ssl_enforcement_enabled      = false
}

# Base postgres database
resource "azurerm_postgresql_database" "pgdb" {
  name                = "${var.environment}db"
  resource_group_name = azurerm_postgresql_server.postgres.resource_group_name
  server_name         = azurerm_postgresql_server.postgres.name
  charset             = "UTF8"
  collation           = "English_United Kingdom.1252"
}

# Airflow database
resource "azurerm_postgresql_database" "airflowpgdb" {
  name                = "airflow"
  resource_group_name = azurerm_postgresql_server.postgres.resource_group_name
  server_name         = azurerm_postgresql_server.postgres.name
  charset             = "UTF8"
  collation           = "English_United Kingdom.1252"
}


# Firewall rules
resource "azurerm_postgresql_firewall_rule" "fw1" {
  name                = "${var.environment}-aks"
  resource_group_name = azurerm_postgresql_server.postgres.resource_group_name
  server_name         = azurerm_postgresql_server.postgres.name
  start_ip_address    = "123.123.123.123"
  end_ip_address      = "234.234.234.234"
}

