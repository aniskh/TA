terraform {
    required_version = " ~> 1.1.9"
    backend "local" {
        path = "/home/aniskhach/tfstates/2_stettings_terrafor.tfstate"
    }
   required_providers {
       docker = {
           source = "kreuzwerker/docker"
           version = " >= 2.16.0"
       }
   }
}


provider docker {
    host = "unix:///var/run/docker.sock"
}

resource "docker_image" "nginx" {
    name = "nginx:latest"
}

resource "docker_container" "nginx" {
    name = "my_web_server"
    image = docker_image.nginx.latest
}