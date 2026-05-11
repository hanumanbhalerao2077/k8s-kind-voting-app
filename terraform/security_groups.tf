resource "aws_security_group" "voting_app" {
  name        = "voting-app-sg"
  description = "Security group for voting app EC2 instances"
  vpc_id      = aws_vpc.voting_app.id

  tags = {
    Name = "voting-app-sg"
  }
}

# SSH access
resource "aws_security_group_rule" "ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.allowed_ssh_cidr
  security_group_id = aws_security_group.voting_app.id
  description       = "SSH access"
}

# Kubernetes API (kind uses port 6443)
resource "aws_security_group_rule" "kubernetes_api" {
  type              = "ingress"
  from_port         = 6443
  to_port           = 6443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.voting_app.id
  description       = "Kubernetes API"
}

# Vote service (port 5000)
resource "aws_security_group_rule" "vote_service" {
  type              = "ingress"
  from_port         = 5000
  to_port           = 5000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.voting_app.id
  description       = "Vote service"
}

# Result service (port 5001)
resource "aws_security_group_rule" "result_service" {
  type              = "ingress"
  from_port         = 5001
  to_port           = 5001
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.voting_app.id
  description       = "Result service"
}

# Kubernetes Dashboard (port 30000)
resource "aws_security_group_rule" "k8s_dashboard" {
  type              = "ingress"
  from_port         = 30000
  to_port           = 30001
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.voting_app.id
  description       = "Kubernetes Dashboard NodePort range"
}

# Grafana (port 3000)
resource "aws_security_group_rule" "grafana" {
  type              = "ingress"
  from_port         = 3000
  to_port           = 3000
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.voting_app.id
  description       = "Grafana"
}

# Prometheus (port 9090)
resource "aws_security_group_rule" "prometheus" {
  type              = "ingress"
  from_port         = 9090
  to_port           = 9090
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.voting_app.id
  description       = "Prometheus"
}

# Allow all outbound traffic
resource "aws_security_group_rule" "egress_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.voting_app.id
  description       = "Allow all outbound traffic"
}

# Internal communication within security group
resource "aws_security_group_rule" "internal_communication" {
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  self              = true
  security_group_id = aws_security_group.voting_app.id
  description       = "Internal communication"
}
