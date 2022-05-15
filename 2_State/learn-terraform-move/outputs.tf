output "public_ip" {
  description = "The Public IP address used to access the instance"
  #value       = aws_instance.example.public_ip
  value = module.ec2_instance.public_ip
}

