## Terraform configuration

terraform {
  cloud {
    organization = "anix"
    workspaces {
      name = "anix-space2"
    }
  }
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
    }
  }
  #required_version = "~> 1.1.9"
}

variable "name_length" {
  description = "The number of words in the pet name"
  default     = "3"
}

resource "random_pet" "pet_name" {
  length    = var.name_length
  separator = "-"
}

output "pet_name" {
  value = random_pet.pet_name.id
}
