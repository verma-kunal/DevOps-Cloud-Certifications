# docker provider:
terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "2.24.0"
    }
  }
}

provider "docker" {}

# Have a docker image - nginx:
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

# Create a container out of that image:
resource "docker_container" "nginx-server" {
  name = "nginx-server"
  image = docker_image.nginx.latest

  # defining the ports:
  ports{
    internal = 80
    external = 8080
    # means to say the same as - "80:8080"
  }
  
}