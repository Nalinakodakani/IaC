output "web_instance_public_ip" {
  value = aws_instance.web_instance[0].public_ip
}

# You can define more outputs as needed
