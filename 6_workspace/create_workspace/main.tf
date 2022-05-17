terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.16.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# Pulls the image
resource "docker_image" "mydebian" {
  name = "mydebian:4"
  build {
    path       = "."
    dockerfile = "./Dockerfile"

  }
  lifecycle {
    prevent_destroy = true
  }
}

# Create a container
resource "docker_container" "debian_terra" {
  image = docker_image.mydebian.latest
  name  = "debian_terra"
  ports {
    internal = "22"
    external = "8022"
    ip       = "0.0.0.0"
    protocol = "tcp"

  }
}