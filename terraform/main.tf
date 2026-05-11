data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_instance" "voting_app" {
  count                = var.instance_count
  ami                  = data.aws_ami.ubuntu.id
  instance_type        = var.instance_type
  subnet_id            = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.voting_app.id]
  key_name             = var.key_pair_name
  
  root_block_device {
    volume_size           = var.root_volume_size
    volume_type           = "gp3"
    delete_on_termination = true
    encrypted             = true
  }

  user_data = base64encode(templatefile("${path.module}/user_data.sh", {
    docker_version  = var.docker_version
    kubectl_version = var.kubectl_version
    kind_version    = var.kind_version
  }))

  monitoring             = true
  iam_instance_profile   = aws_iam_instance_profile.voting_app.name
  associate_public_ip_address = true

  tags = merge(
    var.tags,
    {
      Name = "voting-app-instance-${count.index + 1}"
      Role = "kubernetes-host"
    }
  )

  depends_on = [aws_internet_gateway.voting_app]
}

resource "aws_iam_role" "voting_app" {
  name = "voting-app-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_agent" {
  role       = aws_iam_role.voting_app.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_role_policy_attachment" "cloudwatch" {
  role       = aws_iam_role.voting_app.name
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
}

resource "aws_iam_instance_profile" "voting_app" {
  name = "voting-app-instance-profile"
  role = aws_iam_role.voting_app.name
}

resource "aws_ebs_encryption_by_default" "voting_app" {
  enabled = true
}
