variable "region" {
  description = "Default region"
  default = "ap-southeast-2"
}

variable "s3_bucket_for_terraform_state_file" {
  description = "The pre-setup s3 bucket to store the Terraform state file."
  type = string
}