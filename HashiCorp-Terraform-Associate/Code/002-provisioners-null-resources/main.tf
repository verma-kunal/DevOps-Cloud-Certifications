terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.40.0"
    }
  }
}

# Provider info goes here:
provider "aws" {
  region = "us-east-1"
}

# Creating a Data source for the VPC:
data "aws_vpc" "main" {
  id = "vpc-0155d583e322e06ee"
}

# Resource - "aws_security_group" (to configure the instance security settings such as inbound ports etc.)
resource "aws_security_group" "sg_my_server" {
  name        = "sg_my_server"
  description = "MyServer Security Group"
  vpc_id      = data.aws_vpc.main.id

    # in-coming traffic or request configuration
  ingress = [
    {
        description      = "HTTP"
        from_port        = 80
        to_port          = 80
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = [] # default vpc being used

        # A few params required to be put in ingress:
        prefix_list_ids = []
        security_groups = []
        self = true
    },
    {
        description      = "SSH"
        from_port        = 22
        to_port          = 22
        protocol         = "tcp"
        cidr_blocks      = ["169.149.227.216/32"] # specifying host's IP address here
        ipv6_cidr_blocks = [] # default vpc being used

        # A few params required to be put in ingress:
        prefix_list_ids = []
        security_groups = []
        self = true
    }
  ]

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"] # from anywhere
    ipv6_cidr_blocks = ["::/0"]
  }
}

# Creating an aws ec2 instance:
resource "aws_instance" "my_server" {
  ami           = "ami-0b0dcb5067f052a63"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.deployer.key_name}"

  # Referencing the above created security group here
  vpc_security_group_ids = [ aws_security_group.sg_my_server.id ] 

  tags = {
    Name = "Terraform-Server"
  }
}

# Adding a null resource here:
resource "null_resource" "status" {
  provisioner "local-exec" {
    command = "aws ec2 wait instance-status-ok --instance-ids ${aws_instance.my_server.id}"
  }
  depends_on = [
    aws_instance.my_server
  ]
  
}

output "public_id" {
    value = aws_instance.my_server.public_ip
}