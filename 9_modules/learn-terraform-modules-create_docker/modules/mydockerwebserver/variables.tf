variable "container_name" {
  type        = string
  description = "The name of the container to run"
}
variable "nginx_version" {
  type        = string
  description = "version of nginx image, default latest"
  default     = "latest" # default value, makes variable optional
  nullable    = false    # variable can't be null
}