variable "region" {
  description = "Default region"
  default = "ap-southeast-2"
}

variable "budget_tag" {
  description = "The tag for every element within the project for budgetting. (Key = budget)"
  default = "big data project"
}

variable "s3_bucket_for_terraform_state_file" {
  description = "The pre-setup s3 bucket to store the Terraform state file."
  type = string
}

variable "availability_zone_1" {
  description = "for single zone deployment"
  default = "ap-southeast-2a"
}

variable "availability_zone_2" {
  description = "for single zone deployment"
  default = "ap-southeast-2b"
}

variable "availability_zone_3" {
  description = "for single zone deployment"
  default = "ap-southeast-2c"
}

variable "cluster-name" {
  default = "terraform-eks"
}