terraform {}

# Provider info goes here:
provider "aws" {
  region = "us-east-1"
}


# Importing the module here:
module "apache" {
  source = ".//terraform-aws-apache-example"

  # Giving the variable values here:
  vpc_id = "vpc-0155d583e322e06ee"
  my_ip_with_cidr = "45.127.45.236/32"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCqPf7oxnoW97qxWIxcypCAGyt1cLnsFRfGbCVFIXsVBplmu2MvW4g8UhBHl1xwiU3rGQiCsnfVUcfpQ06x3z/HzQvhiqCeqDdDdcOp8rUoYHtu2YT1n1oA6CgKBEv+b2ma6FELsl5xmqkuUiSTLxfoIVzhykP93S6ZBdCjFJWL1pqoQNMjRpuZpdYTNVw21LRaYkTnu9X964pll2oNmvuRJ32eymY80gSONX/UGY/2a60GWuvBV+5tVuSk2aLWM/gqWplfuH7V13p4zDGY0SbTTBOAJ3EgMk1bC+LAVCVbhgrxbl8f2xQSmEvrEDwdvUTjNpuKuKdR4v5yzhF6VoOybsCYfmiuxudkeOEDoTwErjGLbwqu7WPqhl0ao8RaTCdd0omQbKkc9N7JSqYxrNYJcREI1DzCUpbHmbHVcRDOJEVVnWbC8O3XhxbdEUVyKT3MMD1O2tyfI/mAkHbR16HNC2U6fNVT2NcP8NtFdW8/3CsWQ2XNjQoCUycbYu94k98= kunalverma@Kunals-MacBook-Air.local"
  instance_type = "t2.nano"
  server_name = "Apache-Example-Server"
}

# Outputs:

output "public_ip"{
    value = module.apache.public_id
}