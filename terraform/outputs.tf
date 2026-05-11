output "instance_ids" {
  description = "IDs of EC2 instances"
  value       = aws_instance.voting_app[*].id
}

output "instance_public_ips" {
  description = "Public IP addresses of EC2 instances"
  value       = aws_instance.voting_app[*].public_ip
}

output "instance_dns_names" {
  description = "DNS names of EC2 instances"
  value       = aws_instance.voting_app[*].public_dns
}

output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.voting_app.id
}

output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.voting_app.id
}

output "subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public.id
}

output "ssh_command" {
  description = "Command to SSH into the instance"
  value       = format("ssh -i /path/to/your/key.pem ubuntu@%s", aws_instance.voting_app[0].public_ip)
}

output "kubernetes_api_endpoint" {
  description = "Kubernetes API endpoint"
  value       = format("https://%s:6443", aws_instance.voting_app[0].public_ip)
}

output "vote_service_url" {
  description = "URL to access voting service"
  value       = format("http://%s:5000", aws_instance.voting_app[0].public_ip)
}

output "result_service_url" {
  description = "URL to access result service"
  value       = format("http://%s:5001", aws_instance.voting_app[0].public_ip)
}
