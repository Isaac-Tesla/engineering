resource "azurerm_storage_container" "storage_container" {
  name                  = var.container_name
  storage_account_name  = var.sa_name
  container_access_type = "private"
}