variable "region" {
  description = "Default region"
  default = "australiaeast"
}

variable "subscription" {
  description = "Default subscription"
  type = string
}

variable "data_lake" {
  description = "Name of the data lake storage for the Terraform state files."
  type = string
}

variable "resource_group" {
  description = "Resource group for the Terraform state files."
  type = string
}