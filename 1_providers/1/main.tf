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
      version = "4.12.1"
    }
  }
}

provider "aws" { }

resource "aws_instance" "app_server" {
  #ami           = "ami-0ebc281c20e89ba4b"
  ami           = var.instance_ami  # test updating existing infrastructure
  instance_type = "t2.nano"

  tags = {
    Name = "ExampleAppServerInstance"
  }
}

