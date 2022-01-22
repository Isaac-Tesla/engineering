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
