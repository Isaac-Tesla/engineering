module "resource_group" {
  source  = "../_modules/resource_group"
  rg_name = "${var.environment}-rg"
  rg_loc  = var.region
}

module "storage_account" {
  source  = "../_modules/storage_account"
  sa_name = "${var.environment}datalake"
  rg_name = module.resource_group.resource_group_name
  rg_loc  = module.resource_group.resource_group_location
}

module "storage_account_containers" {
  source  = "../_modules/storage_account_container"
  sa_name = module.storage_account.storage_account_name
  container_name = each.key 

  for_each = toset([
    "dags", 
    "logs",
    "jupyter"
  ])
}

module "kubernetes" {
  source   = "../_modules/kubernetes"
  rg_name  = module.resource_group.resource_group_name
  rg_loc   = module.resource_group.resource_group_location
  kv_id    = data.azurerm_key_vault.key_vault.id
  tnt_id   = data.azurerm_client_config.current.tenant_id
  aks_name = "${var.cluster_name}"
  nrg_name = "${var.environment}-aks"
  dns_name = "${var.environment}-dns"
  nd_pool  = "${var.environment}ndpl"
  # Pass through the ID
  admin_group_object_id = var.admin_group_object_id
}

module "role_assignment_aks_to_acr" {
  source = "../_modules/role_assignment"
  scp    = data.azurerm_container_registry.daccontainerreg.id
  rdn    = "AcrPull"
  pid    = module.kubernetes.aks_oid
}

module "role_assignment_aks" {
  source = "../_modules/role_assignment"
  scp    = module.kubernetes.aks_id
  rdn    = "Monitoring Metrics Publisher"
  pid    = module.kubernetes.aks_pid
}

module "role_assignment_aksblobsp" {
  source = "../_modules/role_assignment"
  scp    = module.storage_account.sa_id
  rdn    = "Storage Blob Data Contributor"
  pid    = module.kubernetes.aks_pid
}

module "role_assignment_aksfilesp" {
  source = "../_modules/role_assignment"
  scp    = module.storage_account.sa_id
  rdn    = "Storage File Data SMB Share Contributor"
  pid    = module.kubernetes.aks_pid
}

module "role_assignment_aksblobsp_listkeys" {
  source = "../_modules/role_assignment"
  scp    = module.storage_account.sa_id
  rdn    = "Storage Account Key Operator Service Role"
  pid    = module.kubernetes.aks_pid
}

module "policy_key_vault_access" {
  source  = "../_modules/policy_key_vault_access"
  aks_pid = module.kubernetes.aks_pid
  t_id    = data.azurerm_client_config.current.tenant_id
  kv_id   = data.azurerm_key_vault.key_vault.id
}