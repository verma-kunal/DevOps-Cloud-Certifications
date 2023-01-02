terraform {
  cloud {
    organization = "kunalverma"

    workspaces {
      name = "force-unlocking"
    }
  }
}

terraform {
  
}

provider "aws" {
  region = "us-east-1"
}

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