provider "google" {}

terraform {
  backend "google" {
    project   = ""
    region  = "australia-southeast1"
    zone    = "australia-southeast1-a"

  }
}