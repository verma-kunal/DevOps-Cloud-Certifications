variable "vpc_id" {
  type = string
}

variable "my_ip_with_cidr" {
  type = string
  description = "provide your IP. Example - 45.127.45.236"
}

variable "public_key" {
  type = string
  description = "public ssh key to login"
}

variable "instance_type" {
  type = string
  default = "t2.nano"
}

variable "server_name" {
  type = string
  default = "Apache-Default-Server"
}