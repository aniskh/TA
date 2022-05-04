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
resource "docker_image" "nginx" {
  name = "nginx:latest"
}

# Create a container
resource "docker_container" "foo" {
  image = docker_image.nginx.latest
  name  = "mywebserver"
  provisioner "local-exec" {
    when    = destroy
    on_failure = continue
    command = "echo container  ${self.name} used following resources : $(docker stats --no-stream --format 'MemPerc: {{.MemPerc}}, CPU:  {{.CPUPerc}}, MemUsage:  {{.MemUsage}}' ${self.name} )"
  }
}