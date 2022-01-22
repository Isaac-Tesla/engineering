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

variable "run_if_file_location" {
  description = "The local file location for the run_if file."
  type = string
}