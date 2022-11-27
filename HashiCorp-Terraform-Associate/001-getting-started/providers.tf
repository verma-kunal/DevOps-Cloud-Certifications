provider "aws" {
  # Configuration options
#   profile = "kunal_tf"
  region  = "us-east-1" # North-Virginia
}

# Creating a new provider to use VPC (as thats in eu-west region)
provider "aws" {
  # Configuration options
#   profile = "kunal_tf"
  region  = "eu-west-1" # North-Virginia
  alias = "eu-west"
}