# Voting App Terraform Configuration

This directory contains Terraform configuration files to provision infrastructure for the voting app on AWS.

## Prerequisites

1. **Terraform**: Install from https://www.terraform.io/downloads.html
2. **AWS Account**: With credentials configured via `aws configure`
3. **EC2 Key Pair**: Create one in AWS Console or via AWS CLI:
   ```bash
   aws ec2 create-key-pair --key-name voting-app --query 'KeyMaterial' --output text > voting-app.pem
   chmod 600 voting-app.pem
   ```

## Files

- **providers.tf**: AWS provider configuration
- **variables.tf**: Input variables (customize as needed)
- **main.tf**: EC2 instance configuration
- **vpc.tf**: VPC and network setup
- **security_groups.tf**: Security group rules
- **outputs.tf**: Output values (IPs, URLs, etc.)
- **user_data.sh**: Bootstrap script (installs Docker, Kind, kubectl, Argo CD)
- **terraform.tfvars**: Variable values (create this file)

## Quick Start

1. **Create terraform.tfvars**:
   ```hcl
   aws_region     = "us-east-1"
   environment    = "dev"
   key_pair_name  = "voting-app"
   instance_type  = "t3.large"
   ```

2. **Initialize Terraform**:
   ```bash
   terraform init
   ```

3. **Plan**:
   ```bash
   terraform plan -out=tfplan
   ```

4. **Apply**:
   ```bash
   terraform apply tfplan
   ```

5. **Get Outputs**:
   ```bash
   terraform output
   ```

6. **SSH into Instance**:
   ```bash
   ssh -i voting-app.pem ubuntu@<public_ip>
   ```

## Customization

Edit `variables.tf` or `terraform.tfvars` to customize:
- AWS region
- Instance type (e.g., t3.xlarge for more resources)
- Number of instances
- Allowed SSH CIDR blocks
- Root volume size

## State Management

For production, enable S3 backend in `providers.tf` to store state remotely and prevent accidental destruction.

## Cleanup

```bash
terraform destroy
```

## Common Commands

```bash
# Validate configuration
terraform validate

# Format code
terraform fmt -recursive

# Show current state
terraform show

# Refresh state from AWS
terraform refresh
```

## Troubleshooting

If Kind cluster fails to start on the EC2 instance, SSH in and check logs:
```bash
sudo tail -f /var/log/user-data.log
docker ps  # Check if Kind containers are running
kind get clusters  # List Kind clusters
```
