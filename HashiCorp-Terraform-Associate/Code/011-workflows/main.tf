terraform {
        cloud {
        hostname = "app.terraform.io"
        organization = "kunalverma"

        workspaces {
        name = "vcs-terraform"
        }
    }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.40.0"
    }
  }
}


# Provider info goes here:
provider "aws" {
  region = "us-east-1"
}


# Importing the module here:
module "apache" {
  # Using our custom module here
  source  = "verma-kunal/apache-example/aws"
  version = "1.0.0"

  vpc_id = var.vpc_id
  my_ip_with_cidr = var.my_ip_with_cidr
  public_key = var.public_key
  instance_type = var.instance_type
  server_name = var.server_name
}

# Outputs:

output "public_ip"{
    value = module.apache.public_id
}