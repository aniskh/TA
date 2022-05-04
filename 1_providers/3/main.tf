terraform {
  required_providers {

    local = {
      source  = "hashicorp/local"
      version = "2.2.2"
    }
  }
}

resource "local_file" "myfile" {
  content  = "Hello world from terraform"
  filename = var.file_path

}