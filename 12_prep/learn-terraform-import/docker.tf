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
  env        = []
  entrypoint = [
    "/docker-entrypoint.sh",
  ]
  group_add         = []
  hostname          = "c863a8b2d855"
  image             = docker_image.nginx.name
  init              = false
  ipc_mode          = "private"
  log_driver        = "json-file"
  log_opts          = {}
  max_retry_count   = 0
  memory            = 0
  memory_swap       = 0
  name              = "hashicorp-learn"
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
  }
}

resource "docker_image" "nginx" {
    name = "nginx:latest"
 }