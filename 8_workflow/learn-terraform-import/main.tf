# Configure docker provider
#
# https://www.terraform.io/docs/providers/docker/index.html
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.16"
    }
  }
  required_version = ">= 0.14"
}

provider "docker" {
  #host    = "npipe:////.//pipe//docker_engine"
  host = "unix:///var/run/docker.sock"

}
/*
resource "docker_container" "web" {
  #name = ' '
}
*/
resource "docker_image" "nginx" {
  name         = "nginx:latest"
}