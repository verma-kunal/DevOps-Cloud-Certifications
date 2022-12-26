terraform {
        cloud {
        hostname = "app.terraform.io"
        organization = "kunalverma"

        workspaces {
        name = "getting-started"
        }
    }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.40.0"
    }
  }
}

# Declaring a local value:
locals {
  project_name = "Kunal"
}