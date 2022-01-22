variable "dataproc_sa_id" {
  description = "Dataproc service account id"
  type = string
}

variable "environment" {
  description = "The environment to deploy in. e.g. PROD, DEV, TEST."
  type = string
}

variable "region" {
  description = "The region to deploy in."
  default     = "australia-southeast1"
}