provider "azuread" {}

provider "azurerm" {
    features {}
    subscription_id = var.subscription
}

terraform {
  backend "azurerm" {
    resource_group_name   = ""
    storage_account_name  = ""
    container_name        = ""
    key                   = ""
  }
}