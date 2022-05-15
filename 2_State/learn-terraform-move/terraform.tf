terraform {
  /* Uncomment this block to use Terraform Cloud for this tutorial
  cloud {
    organization = "organization-name"
    workspaces {
      name = "learn-terraform-move"
    }
  }
  */

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.12.1"
    }
  }
  required_version = ">= 1.1.0"
}
