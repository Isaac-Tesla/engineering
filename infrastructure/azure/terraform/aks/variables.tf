variable "environment" {
    description = "Environment name"
    type = string
}

variable "region" {
  description = "Default region"
  default = "australiaeast"
}

variable "subscription" {
  description = "Default subscription"
  type = string
}

variable admin_group_object_id {
  description = "The ID for the admin group for RBAC permissions on the AKS cluster."
  type = string
}

variable cluster_name {
  description = "The name of the AKS cluster."
  type = string
}

variable cluster_rg {
  description = "Resource group of the AKS cluster."
  type = string
}