terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.45.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Data source for vpc id:
data "aws_vpc" "main" {
  id = "vpc-0155d583e322e06ee"
}

locals {
  ingress = [{

    port = 443
    description = "Port 443"
    protocol = "tcp"
  },
  {

    port = 80
    description = "Port 80"
    protocol = "tcp"

  }]
}

# Defining a security group for AWS
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = data.aws_vpc.main.id

# dynamic block here:
  dynamic "ingress"{

    for_each = local.ingress # accessing the locals block "ingress"
    content{

      description      = ingress.value.description
      from_port        = ingress.value.port
      to_port          = ingress.value.port
      protocol         = ingress.value.protocol
      cidr_blocks      = [data.aws_vpc.main.cidr_block]
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      security_groups = []
      self = false 
    }

  }

  egress { 
    description = "Outgoing connections"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
  }

}