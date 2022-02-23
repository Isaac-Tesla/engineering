variable "rg_name" {
  description = "Resource group name."
  type = string
}

variable "rg_loc" {
  description = "Resource group location."
  type = string
}

variable "kv_id" {
  description = "ID of the key vault."
  type = string
}

variable "tnt_id" {
  description = "ID of the current tenant."
  type = string
}

variable "aks_name" {
  description = "Name of the cluster."
  type = string
}

variable "nrg_name" {
  description = "Nodepool resource group name."
  type = string
}

variable "dns_name" {
  description = "DNS name."
  type = string
}

variable "nd_pool" {
  description = "Nodepool name."
  type = string
}

variable "admin_group_object_id" {
  description = "Admin group ID."
  type = string
}
