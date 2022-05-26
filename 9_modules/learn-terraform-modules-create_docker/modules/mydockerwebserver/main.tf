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

resource "docker_image" "nginx" {
  name = "nginx:${var.nginx_version}"
}
resource "docker_container" "webservercontainer" {
  image = docker_image.nginx.latest
  name  = var.container_name
}