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
  ami           = "ami-0b0dcb5067f052a63"
  instance_type = "t2.micro"

}

# Creating a s3 bucket:
resource "aws_s3_bucket" "b" {
  bucket = "29092002-depends-on"

  # we want this bucket to be provisioned after our instance:
  depends_on = [
    aws_instance.my_server
  ]
}

output "public_ip" {
  value = aws_instance.my_server.public_ip
  sensitive = false
}