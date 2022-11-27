terraform {
    # As we are using Terraform cloud to store our state:
  /*
  cloud {
    hostname = "app.terraform.io"
    organization = "kunalverma"

    workspaces {
      name = "provisioners"
    }
  }
  */
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

# Creating a Data Source to reference the cloud-init script:
data "template_file" "user_data" {
  template = file("./userdata.yaml")
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

    # out-going traffic or request configuration
    # This is automatically set by AWS (when we use UI), but with Terraform we have to explicitly set this
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"] # from anywhere
    ipv6_cidr_blocks = ["::/0"]
  }
}

# Resource - "aws_key_pair" (used to control login access to EC2 instances)
resource "aws_key_pair" "deployer" {
  key_name   = "terraform-key"
  public_key = "YOUR-PUBLIC-KEY-HERE"
}

# Creating an aws ec2 instance:
resource "aws_instance" "my_server" {
  ami           = "ami-0b0dcb5067f052a63"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.deployer.key_name}"

  # Referencing the above created security group here
  vpc_security_group_ids = [ aws_security_group.sg_my_server.id ] 

  # Referencing the userdata template file here (for cloud-init)
  user_data = data.template_file.user_data.rendered

  # Adding the local-exec here:
  # provisioner "local-exec" {
  #   command = "echo ${self.private_ip} >> private_ips.txt"
  # }

  # Adding the remote-exec here:
#   provisioner "remote-exec" {
#     inline = [
#       "echo ${self.private_ip} >> /home/ec2-user/private_ips.txt"
#       # This will create a file in our remote ec2 server
#     ]

#     # Connection-block (required) for SSH block:
#     connection {
#     type     = "ssh"
#     user     = "ec2-user"
#     host     = "${self.public_ip}"
#     private_key = "${file("/home/.ssh/terraform")}"
#   }

# }

  # Adding a file provisioner here:
  provisioner "file" {
    content     = "this is a new file created using file provisioner"
    destination = "/home/ec2-user/newFile.txt"
  }

  tags = {
    Name = "Terraform-Server"
  }
}

output "public_id" {
    value = aws_instance.my_server.public_ip
}
