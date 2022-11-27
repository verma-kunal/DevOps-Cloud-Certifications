resource "aws_instance" "my_server" {
  ami           = "ami-0b0dcb5067f052a63"
  instance_type = var.instance_type # calling the variable here

  tags = {
    Name = "MyServer-${local.project_name}"
  }
}

# Defining a VPC module here:
/*
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  # Referring to the new provider we created for this:
  providers = {
    aws = aws.eu-west 
   }

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}
*/
