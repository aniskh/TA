terraform {
  /* Uncomment this block to use Terraform Cloud for this tutorial
  cloud {
    organization = "organization-name"
    workspaces {
      name = "learn-terraform-provider-versioning"
    }
  }
  */

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1.1"
    }

    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.12.1"
    }
  }

  required_version = ">= 1.1"
}
