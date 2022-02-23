data "azurerm_subscription" "current" {
}

data "azurerm_client_config" "current" {}

data "azuread_client_config" "current" {}

data "azurerm_resource_group" "core_rg" {
  name = "core-rg"
}

data "azurerm_key_vault" "key_vault" {
  name                = "dac-kv"
  resource_group_name = data.azurerm_resource_group.core_rg.name
}

data "azurerm_container_registry" "daccontainerreg" {
  name                = "daccontainerreg"
  resource_group_name = data.azurerm_resource_group.core_rg.name
}
