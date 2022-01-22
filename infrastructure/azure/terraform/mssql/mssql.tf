# MSSQL server
resource "azurerm_sql_server" "mssql" {
  name                     = "${var.environment}-mssql"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  version                  = "12.0"
  administrator_login          = var.mssql_admin
  administrator_login_password = var.mssql_password
}

# TEMP STORAGE
resource "azurerm_storage_account" "mssql" {
  name                     = "${var.environment}mssqlsa"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# MSSQL database
resource "azurerm_mssql_database" "mssqldb" {
  name           = "${var.environment}db"
  server_id      = azurerm_sql_server.mssql.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 2
  sku_name       = "Basic"

  extended_auditing_policy {
    storage_endpoint                        = azurerm_storage_account.mssql.primary_blob_endpoint
    storage_account_access_key              = azurerm_storage_account.mssql.primary_access_key
    storage_account_access_key_is_secondary = true
    retention_in_days                       = 6
  }

  tags = {
    environment = "var.environment"
  }

}


# Firewall rules
resource "azurerm_mssql_firewall_rule" "fw1" {
  name                = "${var.environment}-aks"
  server_id           = azurerm_sql_server.mssql.id
  start_ip_address    = "123.123.123.123"
  end_ip_address      = "234.234.234.234"
}