output "rg_name" {
  value = data.azurerm_resource_group.core_rg.name
}

output "current_subscription_id" {
  value = data.azurerm_subscription.current.id
}

output "vault_id" {
  value = data.azurerm_key_vault.key_vault.id
}

output "cr_id" {
  value = data.azurerm_container_registry.daccontainerreg.id
}