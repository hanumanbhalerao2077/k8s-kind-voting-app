variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Environment must be dev, staging, or prod."
  }
}

variable "instance_type" {
  description = "EC2 instance type for Kind cluster"
  type        = string
  default     = "t3.large"
}

variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 1
  validation {
    condition     = var.instance_count >= 1 && var.instance_count <= 3
    error_message = "Instance count must be between 1 and 3."
  }
}

variable "key_pair_name" {
  description = "AWS EC2 Key Pair name for SSH access"
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed for SSH access"
  type        = list(string)
  default     = ["0.0.0.0/0"] # Change to your IP for security
}

variable "root_volume_size" {
  description = "Root volume size in GB"
  type        = number
  default     = 50
}

variable "docker_version" {
  description = "Docker version to install"
  type        = string
  default     = "latest"
}

variable "kubectl_version" {
  description = "kubectl version to install"
  type        = string
  default     = "latest"
}

variable "kind_version" {
  description = "Kind version to install"
  type        = string
  default     = "latest"
}

variable "enable_monitoring" {
  description = "Enable Prometheus and Grafana deployment"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Additional tags for all resources"
  type        = map(string)
  default     = {}
}
