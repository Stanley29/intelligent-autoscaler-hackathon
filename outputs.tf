output "instance_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.devops_ec2.public_ip
}
