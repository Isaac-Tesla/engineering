resource "azurerm_databricks_workspace" "databricks_workspace" {
  name                = "databricks-user"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "standard"

  tags = {
    Environment = "Production"
  }
}