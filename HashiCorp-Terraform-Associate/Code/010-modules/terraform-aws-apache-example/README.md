# Modules

- Create a module
- Publish a module

Task: Terraform Module to provision an EC2 instance that is running Apache server.

- Following the conventions used here: https://github.com/terraform-aws-modules/terraform-aws-rds

```hcl

terraform {}

# Provider info goes here:
provider "aws" {
  region = "us-east-1"
}


# Importing the module here:
module "apache" {
  source = ".//terraform-aws-apache-example"

  # Giving the variable values here:
  vpc_id = "vpc-0000000"
  my_ip_with_cidr = "<HOST_IP_ADDRESS>/32"
  public_key = "ssh-rsa AAAAB......"
  instance_type = "t2.nano"
  server_name = "Apache-Example-Server"
}

# Outputs:

output "public_ip"{
    value = module.apache.public_id
}

```
