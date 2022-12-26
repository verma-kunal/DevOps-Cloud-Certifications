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

# Defining an input variable:
variable "instance_type"{
  type = string
  description = "The size of the instance!"

  # Adding the validation block here:
  validation {
    condition     = var.instance_type == "t2.micro"
    error_message = "Not equal to the validation rule!"
  }
}

# Creating a data source here:
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_instance" "my_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type # calling the variable here from "terraform.tfvars" file

}

output "public_ip" {
  value = aws_instance.my_server.public_ip
  sensitive = false
}