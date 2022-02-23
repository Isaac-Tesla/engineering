resource "azurerm_role_assignment" "role_ass" {
  scope                = var.scp
  role_definition_name = var.rdn
  principal_id         = var.pid
}