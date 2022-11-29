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
  region  = "us-east-1" 
}

resource "aws_instance" "my_server" {

  ami           = "ami-0b0dcb5067f052a63"
  instance_type = "t2.micro"

  tags = {
    Name = "Tf-server"
  }

  lifecycle {
    prevent_destroy = false
  }

}

output "public_ip" {
  value = aws_instance.my_server.public_ip
  sensitive = false
}