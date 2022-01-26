module "resource_group" {
  source  = "../_modules/resource_group"
  rg_name = "storage-rg"
  rg_loc  = var.region
}

module "storage_account" {
  source  = "../_modules/storage_account"
  sa_name = "storageaccount1"
  rg_name = module.resource_group.resource_group_name
  rg_loc  = module.resource_group.resource_group_location
}

module "storage_account_containers" {
  source  = "../_modules/storage_account_container"
  sa_name = module.storage_account.storage_account_name
  container_name = each.key 

  for_each = toset([
    "container1", 
    "container2",
    "container3"
  ])
}