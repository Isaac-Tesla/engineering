resource "azurerm_key_vault_access_policy" "kv_ap" {
  key_vault_id   = var.kv_id
  tenant_id      = var.t_id
  object_id      = var.aks_pid
  application_id = var.aks_pid

  secret_permissions = [
    "Get", "List"
  ]
}