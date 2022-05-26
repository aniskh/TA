output "container_name" {
  description = "The name of the container launched"
  # value = module.mywebserver.docker_container.webservercontainer.name
  value = [module.mywebserver.container_name, module.mywebserver2.container_name]
}