output "container_name" {
  description = "The name of the container launched"
  value       = docker_container.webservercontainer.name
}