terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.40.0"
    }
  }
}
provider "aws" {
  # Configuration options
  region  = "us-east-1" # North-Virginia
}

resource "aws_instance" "my_server" {

# Using a for_each to define different sizes of the 3 instances 
  for_each = {
    nano = "t2.nano"
    micro = "t2.micro"
    small = "t2.small"
  }
  ami           = "ami-0b0dcb5067f052a63"
  instance_type = each.value

  tags = {
    Name = "TF-Server ${each.key}"
  }

}

output "public_ip" {
  value = toset(values(aws_instance.my_server)[*].public_ip)
  sensitive = false
}