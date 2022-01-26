resource "azurerm_resource_group" "rg" {
  name     = var.rg_name
  location = var.rg_loc
}

output "resource_group_name" {
    description = "The name of the resource group"
    value = azurerm_resource_group.rg.name
}

output "resource_group_location" {
    description = "The location of the resource group"
    value = azurerm_resource_group.rg.location
}

output "resource_group_id" {
    description = "The id of the resource group"
    value = azurerm_resource_group.rg.id
}