# Variable declarations
variable "aws_region" {
  type        = string
  description = "AWS region"
  default     = "eu-west-3"
}
variable "vpc_cidr_block" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.0.0.0/16"
}
variable "ec2_instancecount" {
  type        = number
  default     = 2
  description = "number of ec2 instances "
}
variable "vpc_vpn_gateway_enabled" {
  description = "Enable or not VPN gateway"
  type        = bool
  default     = false

}
variable "public_subnets_count" {
  description = "number of public subnets"
  type        = number
  default     = 2
}
variable "private_subnets_count" {
  description = "number of private subnets"
  type        = number
  default     = 2
}
variable "public_cidr_list" {
  description = "list of cidr for public subnets"
  type        = list(string)
  default = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24",
    "10.0.4.0/24",
    "10.0.5.0/24",
    "10.0.6.0/24",
    "10.0.7.0/24",
    "10.0.8.0/24",
  ]
}
variable "private_cidr_list" {
  description = "list of cidr for private subnets"
  type        = list(string)
  default = [
    "10.0.101.0/24",
    "10.0.102.0/24",
    "10.0.103.0/24",
    "10.0.104.0/24",
    "10.0.105.0/24",
    "10.0.106.0/24",
    "10.0.107.0/24",
    "10.0.108.0/24",
  ]
}
variable "resources_tags" {
  description = "map of the vpc tags"
  type        = map(string)
  default = {
    project     = "project-alpha",
    environment = "dev"
  }
  validation {
    condition     = length(var.resources_tags["project"]) <= 20 && length(regexall("[^a-zA-Z0-9-]", var.resources_tags["project"])) == 0
    error_message = "The project tag must be no more than 16 characters, and only contain letters, numbers, and hyphens."
  }
  validation {
    condition     = contains(["dev", "test", "pre-prod", "prod"], var.resources_tags.environment)
    error_message = "The project environment must be from the predifined list ."
  }
}