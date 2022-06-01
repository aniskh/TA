data "aws_ami" "example" {
  most_recent = true
  owners      = ["099720109477"] # owner: canonical
  filter {
    name   = "name"
    values = ["ubuntu*"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}


resource "aws_instance" "app_server" {
  ami           = data.aws_ami.example.id
  instance_type = "t2.micro"
  tags = {
    Name = "ExampleAppServerInstance"
  }
}

