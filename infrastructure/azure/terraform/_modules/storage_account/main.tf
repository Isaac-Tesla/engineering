resource "azurerm_storage_account" "sa" {
  name                     = var.sa_name
  resource_group_name      = var.rg_name
  location                 = var.rg_loc
  account_tier             = "Standard"
  account_replication_type = "LRS"
  min_tls_version          = "TLS1_2"
}

output "storage_account_name" {
    description = "The name of the storage account."
    value = azurerm_storage_account.sa.name
}

output "sa_id" {
    description = "The ID of the storage account."
    value = azurerm_storage_account.sa.id
}