terraform {
  cloud {
    organization = "anix"
    workspaces {
      name = "anix-space"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.12.0"
    }
  }

  required_version = "~> 1.1.9"

}


provider "aws" {
  #profile = "default"
  region = var.region
}
