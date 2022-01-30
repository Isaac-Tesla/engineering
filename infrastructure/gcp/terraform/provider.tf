terraform {  
  required_providers {    
    google = {      
      source = "hashicorp/google"      
      version = "3.5.0"    
    }  
  }
}

terraform {
  backend "google" {
    credentials = file("serice_account.json")
    project     = "project-1"
    region      = "australia-southeast1"
    zone        = "australia-southeast1-a"
  }
}