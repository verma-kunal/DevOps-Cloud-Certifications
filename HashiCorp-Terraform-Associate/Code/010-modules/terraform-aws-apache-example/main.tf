# Creating a Data source for the VPC:
data "aws_vpc" "main" {
  id = var.vpc_id
}

data "template_file" "user_data" {
  template = file("${abspath(path.module)}/userdata.yaml")
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
        cidr_blocks      = [var.my_ip_with_cidr] # specifying host's IP address here
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

resource "aws_key_pair" "deployer" {
  key_name   = "terraform-key"
  public_key = var.public_key
}

# Data source for AMI:
data "aws_ami" "amazon-linux-2" {
  provider = aws
  most_recent      = true
  owners           = ["amazon"]
  filter {
    name   = "owner-alias"
    values = ["amazon"]
  }
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}


# Creating an aws ec2 instance:
resource "aws_instance" "my_server" {
  ami           = "${data.aws_ami.amazon-linux-2.id}"
  instance_type = var.instance_type
  key_name = "${aws_key_pair.deployer.key_name}"

  vpc_security_group_ids = [ aws_security_group.sg_my_server.id ] 

  user_data = data.template_file.user_data.rendered

  tags = {
    Name = var.server_name
  }
}
