resource "azurerm_storage_account" "big_data" {
  name                     = "hdinsightstor"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "big_data" {
  name                  = "hdinsight"
  storage_account_name  = azurerm_storage_account.big_data.name
  container_access_type = "private"
}