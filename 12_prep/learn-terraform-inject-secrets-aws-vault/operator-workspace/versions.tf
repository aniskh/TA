terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.12.1"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "2.17.0"
    }
  }
}
