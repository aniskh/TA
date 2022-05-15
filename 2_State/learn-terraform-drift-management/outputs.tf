output "instance_id" {
  value = aws_instance.mywebserver.id
}

output "public_ip" {
  value       = aws_instance.mywebserver.public_ip
  description = "The public IP of the web server"
}

output "security_groups" {
  value = [aws_instance.mywebserver.vpc_security_group_ids]
}
