## Replace this file with your configuration from following the scenario.
##
## Final configuration:
#
# resource "docker_image" "nginx" {
#   name = "nginx:latest"
# }
#
# # docker_container.web:
# resource "docker_container" "web" {
#   name  = "hashicorp-learn"
#
#   image = docker_image.nginx.latest
#
#   ports {
#     external = 8081
#     internal = 80
#   }
# }
# docker_container.web:
resource "docker_container" "web" {
  command = [
    "nginx",
    "-g",
    "daemon off;",
  ]
  cpu_shares = 0
  dns        = []
  dns_opts   = []
  dns_search = []
  entrypoint = [
    "/docker-entrypoint.sh",
  ]
  #gateway           = "172.17.0.1"
  group_add = []
  hostname  = "e7d79e5fc496"
  #id                = "e7d79e5fc496a0e9d48eaa9c19f8ad723521b203f714beb4f2cd1e2fe0247595"
  image = docker_image.nginx.latest
  init  = false
  #ip_address        = "172.17.0.2"
  #ip_prefix_length  = 16
  ipc_mode = "private"
  env      = []
  #links             = []
  log_driver      = "json-file"
  log_opts        = {}
  max_retry_count = 0
  memory          = 0
  memory_swap     = 0
  name            = "hashicorp-learn"
  /* network_data      = [
        {
            gateway                   = "172.17.0.1"
            global_ipv6_address       = ""
            global_ipv6_prefix_length = 0
            ip_address                = "172.17.0.2"
            ip_prefix_length          = 16
            ipv6_gateway              = ""
            network_name              = "bridge"
        },
    ]*/
  network_mode      = "default"
  privileged        = false
  publish_all_ports = false
  read_only         = false
  restart           = "no"
  rm                = false
  security_opts     = []
  shm_size          = 64
  stdin_open        = false
  storage_opts      = {}
  sysctls           = {}
  tmpfs             = {}
  tty               = false

  ports {
    external = 8081
    internal = 80
    ip       = "0.0.0.0"
    protocol = "tcp"
  }
}
