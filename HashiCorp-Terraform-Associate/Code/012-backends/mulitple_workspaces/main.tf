terraform {
  backend "s3" {
    bucket = "tf-backend-35834765"
    key    = "terraform.tfstate" # Statefile
    region = "us-east-1"
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

  # specifying the assume_role - according to the workspace we select
  assume_role = "${var.workspace_iam_roles[terraform.workspace]}"
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