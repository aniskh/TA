terraform {
  /* Uncomment this block to use Terraform Cloud for this tutorial
  cloud {
    organization = "organization-name"
    workspaces {
      name = "learn-terraform-console"
    }
  }
*/
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.12.1"
    }
    http = {
      source  = "hashicorp/http"
      version = "2.1.0"
    }
  }

  required_version = "~> 1.1.9"
}
