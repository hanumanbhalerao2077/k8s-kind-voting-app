#!/bin/bash
set -e

# Logging setup
exec > >(tee /var/log/user-data.log)
exec 2>&1

echo "=== Starting user data script ==="
date

# Update system
echo "=== Updating system packages ==="
apt-get update
apt-get upgrade -y
apt-get install -y \
    curl \
    wget \
    git \
    ca-certificates \
    gnupg \
    lsb-release \
    apt-transport-https

# Install Docker
echo "=== Installing Docker ==="
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Start Docker service
systemctl start docker
systemctl enable docker

# Install kubectl
echo "=== Installing kubectl ==="
curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | tee /etc/apt/sources.list.d/kubernetes.list

apt-get update
apt-get install -y kubectl

# Install Kind
echo "=== Installing Kind ==="
curl -Lo /usr/local/bin/kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
chmod +x /usr/local/bin/kind

# Install Helm
echo "=== Installing Helm ==="
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

# Create non-root user with Docker permissions
echo "=== Setting up ubuntu user for Docker ==="
usermod -aG docker ubuntu

# Create Kind cluster config
echo "=== Creating Kind cluster configuration ==="
mkdir -p /home/ubuntu/.kind
cat > /home/ubuntu/.kind/cluster-config.yaml << 'EOF'
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
    extraPortMappings:
      - containerPort: 5000
        hostPort: 5000
        listenAddress: "0.0.0.0"
      - containerPort: 5001
        hostPort: 5001
        listenAddress: "0.0.0.0"
      - containerPort: 30000
        hostPort: 30000
        listenAddress: "0.0.0.0"
      - containerPort: 30001
        hostPort: 30001
        listenAddress: "0.0.0.0"
      - containerPort: 3000
        hostPort: 3000
        listenAddress: "0.0.0.0"
      - containerPort: 9090
        hostPort: 9090
        listenAddress: "0.0.0.0"
    kubeadmConfigPatches:
      - |
        kind: InitConfiguration
        nodeRegistration:
          kubeletExtraArgs:
            node-labels: "ingress-ready=true"
EOF

chown -R ubuntu:ubuntu /home/ubuntu/.kind

# Create Kind cluster (as ubuntu user)
echo "=== Creating Kind cluster ==="
sudo -u ubuntu kind create cluster --name voting-app --config /home/ubuntu/.kind/cluster-config.yaml

# Set kubeconfig permissions
mkdir -p /home/ubuntu/.kube
chown -R ubuntu:ubuntu /home/ubuntu/.kube

# Install metrics-server for HPA
echo "=== Installing metrics-server ==="
sudo -u ubuntu kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# Install Argo CD
echo "=== Installing Argo CD ==="
sudo -u ubuntu kubectl create namespace argocd
sudo -u ubuntu kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Wait for Argo CD deployment
echo "=== Waiting for Argo CD to be ready ==="
sudo -u ubuntu kubectl wait --for=condition=available --timeout=300s deployment/argocd-server -n argocd

echo "=== User data script completed ==="
date
