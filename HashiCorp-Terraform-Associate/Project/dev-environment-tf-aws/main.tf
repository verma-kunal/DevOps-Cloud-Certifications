# Creating a VPC resource:

resource "aws_vpc" "main_vpc" {
    cidr_block = "10.123.0.0/16"

    # enable DNS hostnames:
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
        Name = "dev"
    }
}