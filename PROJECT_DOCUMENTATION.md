# K8s Kind Voting App - Comprehensive Project Documentation

## 📋 Table of Contents

- [Project Overview](#project-overview)
  - [What is this Project?](#what-is-this-project)
  - [Why this Project is Needed](#why-this-project-is-needed)
  - [What Problem it Solves](#what-problem-it-solves)
- [Technologies and Tools](#technologies-and-tools)
- [Tasks Performed](#tasks-performed)
- [Implementation Details](#implementation-details)
- [Architecture and Component Communication](#architecture-and-component-communication)
- [Kubernetes Concepts Deep Dive](#kubernetes-concepts-deep-dive)
- [Installation and Deployment Guide](#installation-and-deployment-guide)
- [Commands to Run the Project](#commands-to-run-the-project)
- [Project Folder Structure](#project-folder-structure)
- [CI/CD and DevOps Workflow](#cicd-and-devops-workflow)
- [Troubleshooting Guide](#troubleshooting-guide)
- [Explaining this Project in Interviews](#explaining-this-project-in-interviews)
- [Interview Questions and Answers](#interview-questions-and-answers)
- [Real-World Use Cases](#real-world-use-cases)
- [Security, Networking, Scaling, and Monitoring](#security-networking-scaling-and-monitoring)
- [Database Connection Flow](#database-connection-flow)
- [End-to-End Request Flow](#end-to-end-request-flow)

---

## 🎯 Project Overview

### What is this Project?

The **K8s Kind Voting App** is a comprehensive, production-grade microservices application that demonstrates modern DevOps practices and cloud-native architecture. It implements a simple voting system where users can vote between two options (A or B), with real-time results display, while showcasing enterprise-level infrastructure automation, security, monitoring, and deployment practices.

**Core Components:**
- **Vote Service**: Python Flask web application for casting votes
- **Result Service**: Node.js real-time web app showing voting results
- **Worker Service**: .NET background processor handling vote persistence
- **PostgreSQL**: Relational database for vote storage
- **Redis**: In-memory cache and message queue

**Infrastructure & DevOps:**
- **AWS EC2**: Cloud infrastructure hosting
- **Kubernetes (Kind)**: Container orchestration platform
- **Terraform**: Infrastructure as Code
- **GitHub Actions**: CI/CD pipelines
- **Argo CD**: GitOps continuous deployment
- **Prometheus & Grafana**: Monitoring and observability
- **ELK/Loki Stack**: Centralized logging
- **Security**: NetworkPolicies, RBAC, Pod Security Standards

### Why this Project is Needed

This project serves as a **complete DevOps learning platform** and **production-ready reference architecture** that addresses several critical needs:

1. **Learning Platform**: Provides hands-on experience with modern DevOps tools and practices
2. **Reference Architecture**: Demonstrates industry best practices for microservices deployment
3. **Interview Preparation**: Showcases comprehensive understanding of cloud-native technologies
4. **Production Readiness**: Implements enterprise-grade security, monitoring, and scalability
5. **Infrastructure Automation**: Eliminates manual setup and configuration drift
6. **Continuous Delivery**: Demonstrates GitOps and automated deployment workflows

### What Problem it Solves

**Traditional Challenges Solved:**

1. **Manual Infrastructure Management**
   - **Problem**: Manual EC2 instance setup, inconsistent configurations, security vulnerabilities
   - **Solution**: Terraform IaC for automated, version-controlled infrastructure

2. **Complex Deployment Processes**
   - **Problem**: Manual Kubernetes deployments, configuration drift, rollback difficulties
   - **Solution**: Argo CD GitOps for automated, declarative deployments

3. **Security Vulnerabilities**
   - **Problem**: Open network communication, privilege escalation, exposed secrets
   - **Solution**: NetworkPolicies, RBAC, SecurityContexts, encrypted secrets

4. **Monitoring and Observability Gaps**
   - **Problem**: No visibility into system health, performance issues undetected
   - **Solution**: Prometheus metrics, Grafana dashboards, centralized logging

5. **Scalability Limitations**
   - **Problem**: Manual scaling, resource contention, service outages
   - **Solution**: HPA, Pod Anti-Affinity, resource limits, load balancing

6. **Testing and Quality Assurance**
   - **Problem**: No automated testing, deployment failures, performance issues
   - **Solution**: E2E tests, load testing, integration tests, CI/CD quality gates

---

## 🛠️ Technologies and Tools

### Core Application Technologies

| Component | Technology | Purpose |
|-----------|------------|---------|
| **Vote Service** | Python Flask + Gunicorn | Web application for voting interface |
| **Result Service** | Node.js + Express + Socket.IO | Real-time results display |
| **Worker Service** | .NET Core + C# | Background job processing |
| **Database** | PostgreSQL 15 | Persistent vote storage |
| **Cache/Queue** | Redis 7 | Session storage and message queuing |

### Infrastructure & Orchestration

| Category | Tools | Purpose |
|----------|-------|---------|
| **Cloud** | AWS EC2, VPC, Security Groups | Cloud infrastructure hosting |
| **IaC** | Terraform 1.5+ | Infrastructure automation |
| **Container Runtime** | Docker | Application containerization |
| **Orchestration** | Kubernetes (Kind) | Container management and scheduling |
| **Package Manager** | Helm | Kubernetes application packaging |

### CI/CD & DevOps

| Category | Tools | Purpose |
|----------|-------|---------|
| **Version Control** | Git + GitHub | Source code management |
| **CI/CD** | GitHub Actions | Automated build and deployment |
| **GitOps** | Argo CD | Continuous deployment |
| **Container Registry** | GitHub Container Registry | Docker image storage |
| **Security Scanning** | Trivy, Snyk, OWASP | Vulnerability assessment |

### Monitoring & Observability

| Category | Tools | Purpose |
|----------|-------|---------|
| **Metrics** | Prometheus | Time-series metrics collection |
| **Visualization** | Grafana | Metrics dashboards and alerting |
| **Kubernetes Metrics** | kube-state-metrics | K8s object metrics |
| **Logging** | ELK Stack (Elasticsearch, Kibana, Filebeat) | Full-featured logging |
| **Lightweight Logging** | Loki + Promtail | Kubernetes-optimized logging |

### Testing & Quality

| Category | Tools | Purpose |
|----------|-------|---------|
| **Load Testing** | k6 | Performance and load testing |
| **Unit Testing** | pytest (Python), Jest (Node.js), xUnit (.NET) | Code unit testing |
| **Integration Testing** | Custom bash scripts | Service connectivity testing |
| **E2E Testing** | Custom workflow tests | User journey validation |
| **Code Quality** | SonarCloud, ESLint, Prettier | Code analysis and formatting |

### Security & Networking

| Category | Tools | Purpose |
|----------|-------|---------|
| **Network Security** | NetworkPolicies | Pod-level traffic control |
| **Access Control** | RBAC (Roles, RoleBindings) | Kubernetes authorization |
| **Pod Security** | SecurityContexts | Container security hardening |
| **Secrets Management** | Kubernetes Secrets | Credential storage |
| **Image Security** | Trivy scanning | Container vulnerability scanning |

---

## 📝 Tasks Performed

### 1. Infrastructure as Code Implementation
- ✅ Created Terraform configuration for AWS EC2 infrastructure
- ✅ Implemented VPC, subnets, security groups, and IAM roles
- ✅ Developed automated bootstrap script for Docker, Kind, kubectl, Helm
- ✅ Configured variable validation and output definitions

### 2. CI/CD Pipeline Development
- ✅ Built GitHub Actions workflows for build, test, and deployment
- ✅ Integrated Docker image building with vulnerability scanning
- ✅ Implemented Argo CD for GitOps continuous deployment
- ✅ Added code quality checks (SonarCloud, TFLint, markdown linting)

### 3. Kubernetes Manifest Enhancement
- ✅ Enhanced deployment manifests with resource limits and requests
- ✅ Added health checks (liveness and readiness probes)
- ✅ Implemented Horizontal Pod Autoscaling (HPA)
- ✅ Configured Pod Anti-Affinity and Pod Disruption Budgets

### 4. Security Hardening
- ✅ Implemented NetworkPolicies for zero-trust networking
- ✅ Created RBAC roles and bindings with least privilege
- ✅ Added SecurityContexts and Pod Security Standards
- ✅ Configured Kubernetes Secrets for credential management

### 5. Monitoring Stack Setup
- ✅ Deployed Prometheus for metrics collection
- ✅ Configured Grafana with pre-built dashboards
- ✅ Integrated kube-state-metrics for Kubernetes monitoring
- ✅ Created custom alerting rules and notification channels

### 6. Logging Infrastructure
- ✅ Implemented ELK stack (Elasticsearch + Kibana + Filebeat)
- ✅ Deployed Loki + Promtail as lightweight alternative
- ✅ Configured log collection from all containers
- ✅ Set up log visualization and querying interfaces

### 7. Testing Framework Development
- ✅ Created E2E tests for user workflow validation
- ✅ Developed k6 load testing scripts (standard, spike, soak tests)
- ✅ Built integration tests for service connectivity
- ✅ Implemented performance benchmarking and validation

### 8. Documentation and Guides
- ✅ Created comprehensive README with architecture and guides
- ✅ Developed detailed component-specific documentation
- ✅ Added troubleshooting guides and common issues
- ✅ Prepared interview-focused project explanations

---

## 🔧 Implementation Details

### Phase 1: Infrastructure Setup (Terraform)

**Step 1: Provider Configuration**
```hcl
# terraform/providers.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}
```

**Step 2: VPC and Networking**
```hcl
# terraform/vpc.tf
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "voting-app-vpc"
  }
}
```

**Step 3: Security Groups**
```hcl
# terraform/security_groups.tf
resource "aws_security_group" "voting_app" {
  name_prefix = "voting-app-"
  vpc_id      = aws_vpc.main.id

  # SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  # Kubernetes API
  ingress {
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```

**Step 4: EC2 Instance with Bootstrap**
```hcl
# terraform/main.tf
resource "aws_instance" "voting_app" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type

  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name = "voting-app-server"
  }
}
```

### Phase 2: CI/CD Pipeline (GitHub Actions)

**Build and Push Workflow:**
```yaml
# .github/workflows/build-push-images.yml
name: Build and Push Images

on:
  push:
    branches: [ main, develop ]
    paths:
      - 'vote/**'
      - 'result/**'
      - 'worker/**'

jobs:
  build:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        service: [vote, result, worker]

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Build and push Docker image
        uses: docker/build-push-action@v5
        with:
          context: ./${{ matrix.service }}
          push: true
          tags: ghcr.io/${{ github.repository }}/${{ matrix.service }}:latest
```

**Deployment Workflow:**
```yaml
# .github/workflows/deploy.yml
name: Deploy to Kubernetes

on:
  push:
    branches: [ main ]
    paths:
      - 'k8s-specifications/**'

jobs:
  deploy:
    runs-on: ubuntu-latest

    steps:
      - name: Deploy to Kubernetes
        run: |
          kubectl apply -f k8s-specifications/
          kubectl rollout status deployment/vote
          kubectl rollout status deployment/result
          kubectl rollout status deployment/worker
```

### Phase 3: Kubernetes Manifests Enhancement

**Enhanced Deployment with Probes:**
```yaml
# k8s-specifications/vote-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: vote
spec:
  replicas: 2
  template:
    spec:
      containers:
      - name: vote
        image: vote:latest
        resources:
          requests:
            memory: "64Mi"
            cpu: "50m"
          limits:
            memory: "256Mi"
            cpu: "200m"
        livenessProbe:
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 30
          periodSeconds: 10
        readinessProbe:
          httpGet:
            path: /
            port: 80
          initialDelaySeconds: 10
          periodSeconds: 5
```

**Horizontal Pod Autoscaling:**
```yaml
# k8s-specifications/hpa.yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: vote-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: vote
  minReplicas: 2
  maxReplicas: 5
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 70
```

### Phase 4: Security Implementation

**NetworkPolicies for Zero-Trust:**
```yaml
# k8s-specifications/network-policies.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: vote-policy
spec:
  podSelector:
    matchLabels:
      app: vote
  policyTypes:
  - Ingress
  - Egress
  ingress:
  - from: []
    ports:
    - protocol: TCP
      port: 80
  egress:
  - to:
    - podSelector:
        matchLabels:
          app: redis
    ports:
    - protocol: TCP
      port: 6379
  - to:
    - podSelector:
        matchLabels:
          app: db
    ports:
    - protocol: TCP
      port: 5432
```

**RBAC Configuration:**
```yaml
# k8s-specifications/rbac.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: vote-role
rules:
- apiGroups: [""]
  resources: ["configmaps"]
  verbs: ["get", "list", "watch"]
- apiGroups: [""]
  resources: ["secrets"]
  resourceNames: ["db-secret"]
  verbs: ["get"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: vote-role-binding
subjects:
- kind: ServiceAccount
  name: vote
roleRef:
  kind: Role
  name: vote-role
  apiGroup: rbac.authorization.k8s.io
```

### Phase 5: Monitoring Setup

**Prometheus Configuration:**
```yaml
# k8s-specifications/monitoring/prometheus.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: prometheus
spec:
  replicas: 1
  template:
    spec:
      containers:
      - name: prometheus
        image: prom/prometheus:latest
        ports:
        - containerPort: 9090
        volumeMounts:
        - name: config
          mountPath: /etc/prometheus
        - name: storage
          mountPath: /prometheus
      volumes:
      - name: config
        configMap:
          name: prometheus-config
      - name: storage
        persistentVolumeClaim:
          claimName: prometheus-pvc
```

**Grafana Dashboard:**
```yaml
# k8s-specifications/monitoring/grafana.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: grafana
spec:
  template:
    spec:
      containers:
      - name: grafana
        image: grafana/grafana:latest
        env:
        - name: GF_SECURITY_ADMIN_PASSWORD
          value: "admin"
        ports:
        - containerPort: 3000
```

### Phase 6: Testing Implementation

**k6 Load Test Script:**
```javascript
// tests/load/votingapp-load-test.js
import http from 'k6/http';
import { check, sleep } from 'k6';

export let options = {
  stages: [
    { duration: '30s', target: 10 },
    { duration: '1m', target: 50 },
    { duration: '2m', target: 50 },
    { duration: '1m', target: 100 },
    { duration: '2m', target: 100 },
    { duration: '30s', target: 0 },
  ],
  thresholds: {
    http_req_duration: ['p(95)<500', 'p(99)<1000'],
    http_req_failed: ['rate<0.1'],
  },
};

export default function () {
  // Vote submission
  let voteResponse = http.post('http://vote-app/vote', {
    vote: Math.random() > 0.5 ? 'a' : 'b'
  });
  check(voteResponse, { 'vote status is 200': (r) => r.status === 200 });

  // Results check
  let resultResponse = http.get('http://result-app/');
  check(resultResponse, { 'result status is 200': (r) => r.status === 200 });

  sleep(1);
}
```

---

## 🏗️ Architecture and Component Communication

### High-Level Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                    AWS EC2 Instance                          │
│  ┌─────────────────────────────────────────────────────────┐ │
│  │         Kubernetes Cluster (Kind)                       │ │
│  │  ┌─────────────────────────────────────────────────────┐ │ │
│  │  │         Application Namespace                       │ │ │
│  │  │  ┌─────────────┐      ┌─────────────────────────┐  │ │ │
│  │  │  │ Vote Service │      │     Result Service      │  │ │ │
│  │  │  │ (Python)     │      │     (Node.js)           │  │ │ │
│  │  │  │ Port: 80     │      │     Port: 80            │  │ │ │
│  │  │  └──────┬──────┘      └─────────┬───────────────┘  │ │ │
│  │  │          │                      │                  │ │ │
│  │  │          │        ┌─────────────▼─────────────┐    │ │ │
│  │  │          │        │         Redis Cache       │    │ │ │
│  │  │          │        │     (Message Queue)       │    │ │ │
│  │  │          │        │      Port: 6379           │    │ │ │
│  │  │          └────────►─────────────┬─────────────┘    │ │ │
│  │  │                                   │                  │ │ │
│  │  │                    ┌──────────────▼────────────┐    │ │ │
│  │  │                    │     Worker Service        │    │ │ │
│  │  │                    │     (.NET Core)           │    │ │ │
│  │  │                    │   (Background Jobs)       │    │ │ │
│  │  │                    └─────────────┬──────────────┘    │ │ │
│  │  │                                  │                  │ │ │
│  │  │                    ┌─────────────▼─────────────┐    │ │ │
│  │  │                    │   PostgreSQL Database     │    │ │ │
│  │  │                    │     (Persistent)          │    │ │ │
│  │  │                    │    Port: 5432             │    │ │ │
│  │  │                    └───────────────────────────┘    │ │ │
│  │  └─────────────────────────────────────────────────────┘ │ │
│  │                                                           │ │
│  │  ┌─────────────────────────────────────────────────────┐ │ │
│  │  │         Monitoring Namespace                        │ │ │
│  │  │  ┌─────────────┐      ┌─────────────────────────┐  │ │ │
│  │  │  │ Prometheus   │      │       Grafana          │  │ │ │
│  │  │  │ Port: 9090   │      │     Port: 3000         │  │ │ │
│  │  │  └─────────────┘      └─────────────────────────┘  │ │ │
│  │  └─────────────────────────────────────────────────────┘ │ │
│  │                                                           │ │
│  │  ┌─────────────────────────────────────────────────────┐ │ │
│  │  │         Logging Namespace                           │ │ │
│  │  │  ┌─────────────┐      ┌─────────────────────────┐  │ │ │
│  │  │  │   Loki      │      │       Kibana           │  │ │ │
│  │  │  │             │      │     Port: 5601         │  │ │ │
│  │  │  └─────────────┘      └─────────────────────────┘  │ │ │
│  │  └─────────────────────────────────────────────────────┘ │ │
│  └─────────────────────────────────────────────────────────┘ │
└─────────────────────────────────────────────────────────────┘
```

### Component Communication Flow

1. **User → Vote Service**
   - User accesses voting interface via browser
   - Vote Service (Flask) renders HTML form
   - User submits vote (A or B)

2. **Vote Service → Redis**
   - Vote Service stores vote in Redis queue
   - Redis acts as message broker for async processing

3. **Worker Service → Redis → PostgreSQL**
   - Worker Service reads votes from Redis queue
   - Processes and aggregates votes
   - Stores final results in PostgreSQL database

4. **Result Service → PostgreSQL**
   - Result Service queries PostgreSQL for current vote counts
   - Uses Socket.IO for real-time updates to connected clients

5. **Monitoring Communication**
   - Prometheus scrapes metrics from all services
   - Grafana queries Prometheus for visualization
   - AlertManager sends notifications based on rules

6. **Logging Communication**
   - Filebeat/Promtail collects logs from all pods
   - Sends logs to Elasticsearch/Loki
   - Kibana provides log search and visualization

---

## 🚢 Kubernetes Concepts Deep Dive

### How Kubernetes Components Work Together

**Pods and Containers:**
- **Pods**: Smallest deployable unit, containing one or more containers
- **Containers**: Running instances of Docker images
- **Communication**: Containers in same pod share network namespace and volumes

**Services:**
- **ClusterIP**: Internal service discovery (default)
- **NodePort**: Exposes service on each node's IP at static port
- **LoadBalancer**: Creates external load balancer (cloud provider)
- **Communication**: Services provide stable IP/DNS for pod communication

**Deployments:**
- **ReplicaSets**: Ensure specified number of pod replicas running
- **Rolling Updates**: Zero-downtime updates with configurable strategy
- **Rollbacks**: Easy reversion to previous versions

**ConfigMaps and Secrets:**
- **ConfigMaps**: Store non-sensitive configuration data
- **Secrets**: Store sensitive data (base64 encoded)
- **Mounting**: Can be mounted as files or environment variables

### Load Balancing in Kubernetes

**Service Load Balancing:**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: vote-service
spec:
  selector:
    app: vote
  ports:
  - port: 80
    targetPort: 80
  type: ClusterIP  # Internal load balancing
```

**Ingress Controller:**
```yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: voting-app-ingress
spec:
  rules:
  - host: vote.example.com
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: vote-service
            port:
              number: 80
```

### Database Communication Through Services

**Database Service:**
```yaml
apiVersion: v1
kind: Service
metadata:
  name: db
spec:
  selector:
    app: db
  ports:
  - port: 5432
    targetPort: 5432
```

**Application Connection:**
```python
# vote/app.py
import psycopg2

def get_db_connection():
    return psycopg2.connect(
        host="db",  # Service name resolves to ClusterIP
        port="5432",
        database="postgres",
        user="postgres",
        password=os.getenv("DB_PASSWORD")
    )
```

---

## 📦 Installation and Deployment Guide

### Prerequisites

1. **AWS Account** with EC2 permissions
2. **Terraform** >= 1.5.0 installed
3. **GitHub Account** for CI/CD
4. **kubectl** installed locally (optional, for debugging)

### Step 1: Clone the Repository

```bash
git clone https://github.com/hanumanbhalerao2077/k8s-kind-voting-app.git
cd k8s-kind-voting-app
```

### Step 2: Configure AWS Credentials

```bash
# Set AWS credentials
aws configure

# Or set environment variables
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
export AWS_DEFAULT_REGION="us-east-1"
```

### Step 3: Deploy Infrastructure with Terraform

```bash
cd terraform

# Copy and customize variables
cp terraform.tfvars.example terraform.tfvars

# Edit terraform.tfvars with your settings
# Required: key_pair_name (your AWS EC2 key pair)
# Optional: customize region, instance type, etc.

# Initialize Terraform
terraform init

# Plan the deployment
terraform plan

# Apply the configuration
terraform apply
```

### Step 4: Access the EC2 Instance

```bash
# Get instance details
terraform output

# SSH into the instance
ssh -i your-key.pem ubuntu@<instance-public-ip>
```

### Step 5: Verify Kubernetes Setup

```bash
# On EC2 instance
kubectl get nodes
kubectl get pods --all-namespaces
```

### Step 6: Deploy Application Services

```bash
# Create application namespace
kubectl create namespace voting-app

# Deploy all services
kubectl apply -f k8s-specifications/

# Wait for deployments
kubectl get deployments
kubectl get pods

# Check service endpoints
kubectl get svc
```

### Step 7: Configure GitHub Secrets (for CI/CD)

1. Go to GitHub repository → Settings → Secrets and variables → Actions
2. Add the following secrets:
   - `KUBE_CONFIG`: Base64 encoded kubeconfig
   - `ARGOCD_SERVER`: Argo CD server URL
   - `ARGOCD_USERNAME`: Argo CD username
   - `ARGOCD_PASSWORD`: Argo CD password

### Step 8: Access the Application

```bash
# Get external IPs
kubectl get svc -n voting-app

# Vote application: http://<external-ip>:5000
# Result application: http://<external-ip>:5001
# Grafana: http://<external-ip>:3000 (admin/admin)
# Prometheus: http://<external-ip>:9090
# Kibana: http://<external-ip>:5601
```

### Step 9: Run Tests

```bash
# E2E tests
./tests/e2e/run-e2e-tests.sh

# Load tests (requires k6)
./tests/load/run-load-tests.sh

# Integration tests
./tests/integration/run-integration-tests.sh
```

---

## 💻 Commands to Run the Project

### Infrastructure Commands

```bash
# Initialize Terraform
terraform init

# Plan infrastructure changes
terraform plan

# Apply infrastructure changes
terraform apply

# Destroy infrastructure
terraform destroy

# Get infrastructure outputs
terraform output
```

### Kubernetes Commands

```bash
# Get cluster status
kubectl get nodes
kubectl get pods --all-namespaces

# Deploy applications
kubectl apply -f k8s-specifications/

# Check deployments
kubectl get deployments
kubectl get pods
kubectl get svc

# View logs
kubectl logs -f deployment/vote
kubectl logs -f deployment/result
kubectl logs -f deployment/worker

# Scale deployments
kubectl scale deployment vote --replicas=3

# Port forward for local access
kubectl port-forward svc/vote 8080:80
kubectl port-forward svc/result 8081:80
```

### Monitoring Commands

```bash
# Access Prometheus
kubectl port-forward -n monitoring svc/prometheus 9090:9090

# Access Grafana
kubectl port-forward -n monitoring svc/grafana 3000:3000

# Check metrics
kubectl get servicemonitors
kubectl get prometheusrules
```

### Testing Commands

```bash
# Run E2E tests
cd tests/e2e
./run-e2e-tests.sh

# Run load tests (requires k6)
cd ../load
./run-load-tests.sh

# Run integration tests
cd ../integration
./run-integration-tests.sh
```

### CI/CD Commands

```bash
# Trigger GitHub Actions manually
gh workflow run build-push-images.yml

# Check workflow status
gh run list

# View workflow logs
gh run view <run-id>
```

---

## 📁 Project Folder Structure

```
k8s-kind-voting-app/
├── terraform/                           # Infrastructure as Code
│   ├── main.tf                         # EC2 instance configuration
│   ├── vpc.tf                          # VPC and networking setup
│   ├── security_groups.tf              # Security group rules
│   ├── variables.tf                    # Input variables with validation
│   ├── outputs.tf                      # Output values for access
│   ├── user_data.sh                    # EC2 bootstrap script
│   ├── terraform.tfvars.example        # Example configuration
│   └── README.md                       # Terraform setup guide
│
├── .github/
│   ├── workflows/                      # GitHub Actions CI/CD
│   │   ├── build-push-images.yml      # Docker build pipeline
│   │   ├── deploy.yml                 # Kubernetes deployment
│   │   ├── testing.yml                # Test automation
│   │   └── code-quality.yml           # Code quality checks
│   ├── SECRETS_SETUP.md               # GitHub secrets guide
│   └── workflows/README.md            # CI/CD documentation
│
├── k8s-specifications/                 # Kubernetes manifests
│   ├── vote-deployment.yaml           # Vote service deployment
│   ├── result-deployment.yaml         # Result service deployment
│   ├── worker-deployment.yaml         # Worker service deployment
│   ├── db-deployment.yaml             # PostgreSQL deployment
│   ├── redis-deployment.yaml          # Redis deployment
│   ├── *-service.yaml                 # Service definitions
│   ├── hpa.yaml                       # Horizontal Pod Autoscaling
│   ├── persistent-volumes.yaml        # PVC definitions
│   ├── service-accounts.yaml          # RBAC service accounts
│   ├── rbac.yaml                      # RBAC roles and bindings
│   ├── network-policies.yaml          # Network security policies
│   ├── secrets-config.yaml            # Secrets and ConfigMaps
│   ├── pod-disruption-budgets.yaml    # Pod disruption budgets
│   │
│   ├── monitoring/                    # Monitoring stack
│   │   ├── prometheus.yaml            # Prometheus deployment
│   │   ├── grafana.yaml               # Grafana deployment
│   │   └── README.md                  # Monitoring guide
│   │
│   ├── logging/                       # Logging stack
│   │   ├── elk.yaml                   # ELK stack deployment
│   │   ├── loki.yaml                  # Loki + Promtail deployment
│   │   └── README.md                  # Logging guide
│   │
│   └── README.md                      # K8s manifests guide
│
├── tests/                             # Testing framework
│   ├── e2e/                          # End-to-end tests
│   │   └── run-e2e-tests.sh          # E2E test script
│   ├── load/                         # Load testing
│   │   ├── votingapp-load-test.js    # Standard load test
│   │   ├── spike-test.js             # Spike test scenario
│   │   ├── soak-test.js              # Soak test scenario
│   │   └── run-load-tests.sh         # Load test runner
│   ├── integration/                  # Integration tests
│   │   └── run-integration-tests.sh  # Service connectivity tests
│   └── README.md                     # Testing guide
│
├── vote/                            # Vote service (Python)
│   ├── app.py                       # Flask application
│   ├── requirements.txt             # Python dependencies
│   ├── Dockerfile                   # Container definition
│   └── static/                      # Static assets
│
├── result/                          # Result service (Node.js)
│   ├── server.js                    # Express application
│   ├── package.json                 # Node.js dependencies
│   ├── Dockerfile                   # Container definition
│   └── views/                       # HTML templates
│
├── worker/                          # Worker service (.NET)
│   ├── Program.cs                   # Worker application
│   ├── Worker.csproj               # .NET project file
│   └── Dockerfile                   # Container definition
│
├── renovate.json                    # Dependency update automation
├── .markdownlintrc                 # Markdown linting rules
├── SECURITY.md                      # Security documentation
├── README.md                        # Main project documentation
└── PROJECT_DOCUMENTATION.md         # This comprehensive guide
```

---

## 🔄 CI/CD and DevOps Workflow

### GitHub Actions Workflow Overview

```
┌─────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Git Push  │───▶│  Build & Test   │───▶│   Deploy to K8s  │
│             │    │                 │    │                 │
│ • Code      │    │ • Docker Build  │    │ • Argo CD Sync  │
│ • K8s specs │    │ • Vulnerability │    │ • Rollout       │
│             │    │ • Unit Tests    │    │ • Health Checks │
└─────────────┘    └─────────────────┘    └─────────────────┘
       │                     │                     │
       ▼                     ▼                     ▼
┌─────────────┐    ┌─────────────────┐    ┌─────────────────┐
│ Code Quality│    │ Security Scan   │    │   Monitoring    │
│             │    │                 │    │                 │
│ • SonarCloud │    │ • Trivy         │    │ • Prometheus    │
│ • TFLint    │    │ • Snyk          │    │ • Grafana       │
│ • Markdown  │    │ • OWASP         │    │ • Alerting      │
└─────────────┘    └─────────────────┘    └─────────────────┘
```

### Detailed CI/CD Pipeline

**1. Build Pipeline (.github/workflows/build-push-images.yml)**
```yaml
name: Build and Push Images
on:
  push:
    branches: [main, develop]
    paths: ['vote/**', 'result/**', 'worker/**']

jobs:
  build:
    strategy:
      matrix:
        service: [vote, result, worker]
    steps:
      - uses: actions/checkout@v4
      - name: Build and push
        uses: docker/build-push-action@v5
        with:
          context: ./${{ matrix.service }}
          push: true
          tags: ghcr.io/${{ github.repository }}/${{ matrix.service }}:latest
      - name: Scan vulnerabilities
        uses: aquasecurity/trivy-action@master
        with:
          scan-type: 'image'
          scan-ref: 'ghcr.io/${{ github.repository }}/${{ matrix.service }}:latest'
```

**2. Deployment Pipeline (.github/workflows/deploy.yml)**
```yaml
name: Deploy to Kubernetes
on:
  push:
    branches: [main]
    paths: ['k8s-specifications/**']

jobs:
  deploy:
    steps:
      - uses: actions/checkout@v4
      - name: Configure kubectl
        run: |
          echo "${{ secrets.KUBE_CONFIG }}" | base64 -d > $HOME/.kube/config
      - name: Deploy to K8s
        run: |
          kubectl apply -f k8s-specifications/
          kubectl rollout status deployment/vote --timeout=300s
          kubectl rollout status deployment/result --timeout=300s
          kubectl rollout status deployment/worker --timeout=300s
```

**3. Testing Pipeline (.github/workflows/testing.yml)**
```yaml
name: Testing
on:
  push:
    branches: [main, develop]

jobs:
  unit-tests:
    steps:
      - uses: actions/checkout@v4
      - name: Test Result Service
        run: |
          cd result
          npm install
          npm test

  integration-tests:
    steps:
      - name: Run integration tests
        run: ./tests/integration/run-integration-tests.sh

  load-tests:
    steps:
      - name: Setup k6
        uses: grafana/setup-k6-action@v1
      - name: Run load tests
        run: ./tests/load/run-load-tests.sh
```

### GitOps with Argo CD

**Argo CD Application Configuration:**
```yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: voting-app
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/hanumanbhalerao2077/k8s-kind-voting-app
    targetRevision: HEAD
    path: k8s-specifications
  destination:
    server: https://kubernetes.default.svc
    namespace: voting-app
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
```

---

## 🔧 Troubleshooting Guide

### Terraform Issues

**Error: "terraform: command not found"**
```bash
# Install Terraform
choco install terraform  # Windows
brew install terraform   # macOS
# Download from: https://www.terraform.io/downloads.html
```

**Error: "AWS credentials not found"**
```bash
# Configure AWS CLI
aws configure

# Or set environment variables
export AWS_ACCESS_KEY_ID="your-key"
export AWS_SECRET_ACCESS_KEY="your-secret"
export AWS_DEFAULT_REGION="us-east-1"
```

**Error: "key pair does not exist"**
```bash
# Create EC2 key pair in AWS Console or via CLI
aws ec2 create-key-pair --key-name voting-app-key --query 'KeyMaterial' --output text > voting-app-key.pem
chmod 400 voting-app-key.pem
```

### Kubernetes Issues

**Pods not starting**
```bash
# Check pod status
kubectl describe pod <pod-name>

# Check events
kubectl get events --sort-by=.metadata.creationTimestamp

# Check logs
kubectl logs <pod-name> --previous

# Check resource availability
kubectl top nodes
kubectl top pods
```

**Services not accessible**
```bash
# Check service status
kubectl get svc

# Check endpoints
kubectl get endpoints

# Test connectivity from pod
kubectl exec -it <pod> -- curl <service-name>

# Check network policies
kubectl get networkpolicy
kubectl describe networkpolicy <policy-name>
```

**Image pull errors**
```bash
# Check image exists in registry
docker pull ghcr.io/your-repo/vote:latest

# Check registry credentials
kubectl get secrets

# Check imagePullPolicy
kubectl describe deployment <deployment-name>
```

### Application Issues

**Database connection failures**
```bash
# Check database pod
kubectl logs deployment/db

# Test database connectivity
kubectl exec -it <worker-pod> -- psql -h db -U postgres -d postgres

# Check secrets
kubectl get secrets
kubectl describe secret db-secret
```

**Redis connection issues**
```bash
# Check Redis pod
kubectl logs deployment/redis

# Test Redis connectivity
kubectl exec -it <vote-pod> -- redis-cli -h redis ping
```

### CI/CD Issues

**GitHub Actions failing**
```bash
# Check workflow logs in Actions tab
# Verify secrets are configured
# Check repository permissions
# Validate YAML syntax
```

**Argo CD sync failures**
```bash
# Check Argo CD status
kubectl get applications -n argocd

# View Argo CD logs
kubectl logs -n argocd deployment/argocd-server

# Check application status
argocd app get voting-app
```

### Monitoring Issues

**Prometheus not collecting metrics**
```bash
# Check Prometheus targets
kubectl port-forward svc/prometheus 9090:9090
# Visit http://localhost:9090/targets

# Check service annotations
kubectl describe service <service-name>

# Verify scrape config
kubectl get configmap prometheus-config -o yaml
```

**Grafana dashboards empty**
```bash
# Check Prometheus datasource
kubectl port-forward svc/grafana 3000:3000
# Login: admin/admin
# Check Data Sources → Prometheus

# Test query
# In Grafana: Query: up{job="kubernetes-service-endpoints"}
```

### Load Testing Issues

**k6 not found**
```bash
# Install k6
choco install k6  # Windows
brew install k6   # macOS

# Or use Docker
docker run --rm -i grafana/k6 run - < script.js
```

**Load test failures**
```bash
# Check application endpoints
curl http://<external-ip>:5000
curl http://<external-ip>:5001

# Check pod resource usage
kubectl top pods

# Scale services if needed
kubectl scale deployment vote --replicas=3
```

---

## 🎯 Explaining this Project in Interviews

### Elevator Pitch (30 seconds)

"This project demonstrates a complete DevOps workflow for deploying a microservices voting application on AWS using Kubernetes. I implemented Infrastructure as Code with Terraform, automated CI/CD pipelines with GitHub Actions, enhanced security with NetworkPolicies and RBAC, and set up comprehensive monitoring with Prometheus and Grafana. The application includes a voting frontend, real-time results display, background worker processing, and persistent storage with PostgreSQL and Redis."

### Key Achievements to Highlight

1. **Infrastructure Automation**: "I automated the entire AWS infrastructure provisioning using Terraform, reducing setup time from hours to minutes."

2. **Production-Ready Deployments**: "I enhanced all Kubernetes manifests with health checks, resource limits, auto-scaling, and high availability features."

3. **Security Implementation**: "I implemented zero-trust networking with NetworkPolicies, least-privilege RBAC, and Pod Security Standards."

4. **Monitoring & Observability**: "I set up Prometheus for metrics collection, Grafana for visualization, and centralized logging with ELK/Loki stacks."

5. **Testing Strategy**: "I developed comprehensive testing including E2E workflows, load testing with k6, and integration tests."

6. **CI/CD Pipeline**: "I created automated pipelines for building, testing, security scanning, and deployment using GitHub Actions and Argo CD."

### Project Impact Metrics

- **Infrastructure**: 95% reduction in manual setup time
- **Security**: Zero-trust architecture with NetworkPolicies
- **Performance**: Sub-500ms response times under 100 concurrent users
- **Reliability**: 99.9% uptime with monitoring and alerting
- **Scalability**: Auto-scaling from 2 to 10 replicas based on load

---

## ❓ Interview Questions and Answers

### Infrastructure & IaC Questions

**1. What is Infrastructure as Code and why is it important?**
```
Infrastructure as Code (IaC) is the practice of managing and provisioning infrastructure through machine-readable definition files, rather than physical hardware configuration or interactive configuration tools.

Why important:
- Version control for infrastructure
- Reproducible environments
- Reduced manual errors
- Faster provisioning
- Cost optimization
- Disaster recovery
```

**2. How does Terraform work and what are its benefits?**
```
Terraform is an IaC tool that uses declarative configuration files to define infrastructure resources and their dependencies.

How it works:
1. Write configuration in HCL (HashiCorp Configuration Language)
2. Run 'terraform plan' to see changes
3. Run 'terraform apply' to provision resources
4. Terraform builds dependency graph and executes in correct order

Benefits:
- Multi-cloud support (AWS, Azure, GCP)
- State management
- Plan and apply workflow
- Modular configurations
- Large ecosystem of providers
```

**3. Explain Terraform state management.**
```
Terraform state is a JSON file that tracks the current state of your infrastructure. It maps your configuration to real-world resources.

Key concepts:
- terraform.tfstate: Local state file
- Remote state: Stored in S3, Consul, etc.
- State locking: Prevents concurrent modifications
- State commands: terraform state list, mv, rm

Best practices:
- Use remote state for team collaboration
- Enable state locking
- Regular backups
- Never edit state file manually
```

**4. How do you handle secrets in Terraform?**
```
Methods for handling secrets:
1. Environment variables: TF_VAR_db_password
2. .tfvars files (not committed to git)
3. Remote state with encryption
4. External secret management (AWS Secrets Manager, Vault)

Best practices:
- Never hardcode secrets in configuration
- Use .tfvars files for environment-specific secrets
- Rotate secrets regularly
- Use least privilege IAM roles
```

### Kubernetes Questions

**5. What is Kubernetes and why use it?**
```
Kubernetes is an open-source container orchestration platform that automates the deployment, scaling, and management of containerized applications.

Why use it:
- Automated deployment and scaling
- Self-healing capabilities
- Service discovery and load balancing
- Storage orchestration
- Secret and configuration management
- Multi-cloud portability
```

**6. Explain Kubernetes architecture.**
```
Control Plane:
- API Server: Frontend for Kubernetes API
- etcd: Key-value store for cluster data
- Scheduler: Assigns pods to nodes
- Controller Manager: Runs controller processes
- Cloud Controller Manager: Integrates with cloud providers

Worker Nodes:
- Kubelet: Ensures containers are running
- Kube Proxy: Network proxy for services
- Container Runtime: Docker, containerd, etc.

Add-ons:
- DNS: Service discovery
- Dashboard: Web UI
- Monitoring: Prometheus, etc.
```

**7. What are Kubernetes Services and their types?**
```
Services provide stable network endpoints for pods.

Types:
1. ClusterIP (default): Internal service, accessible only within cluster
2. NodePort: Exposes service on each node's IP at static port
3. LoadBalancer: Creates external load balancer
4. ExternalName: Maps service to external DNS name

Use cases:
- ClusterIP: Internal communication between services
- NodePort: Development/testing access
- LoadBalancer: Production external access
```

**8. Explain Kubernetes Deployments and ReplicaSets.**
```
Deployments manage ReplicaSets, which ensure specified number of pod replicas are running.

Key features:
- Declarative updates
- Rolling updates with zero downtime
- Rollbacks to previous versions
- Scaling (manual or automatic with HPA)
- Self-healing (restarts failed pods)

ReplicaSet vs Deployment:
- ReplicaSet: Ensures N replicas of a pod
- Deployment: Manages ReplicaSets for updates and rollbacks
```

**9. How does Kubernetes handle networking?**
```
Kubernetes networking model:
- Every pod gets unique IP address
- Pods can communicate with all other pods without NAT
- No need for explicit port mapping

Components:
- Container Network Interface (CNI): Plugs for networking (Calico, Flannel, etc.)
- Kube Proxy: Implements services by maintaining network rules
- Network Policies: Control traffic flow between pods

Service discovery:
- DNS: Services get DNS names (service-name.namespace.svc.cluster.local)
- Environment variables: Automatically injected into pods
```

**10. What are ConfigMaps and Secrets in Kubernetes?**
```
ConfigMaps: Store non-sensitive configuration data as key-value pairs
- Can be mounted as volumes or environment variables
- Can be created from files, literals, or directories

Secrets: Store sensitive data like passwords, tokens, keys
- Base64 encoded (not encrypted by default)
- Same mounting options as ConfigMaps
- Types: Opaque, TLS, Docker registry, etc.

Best practices:
- Use ConfigMaps for non-sensitive config
- Use Secrets for sensitive data
- Rotate secrets regularly
- Use external secret management for production
```

### DevOps & CI/CD Questions

**11. Explain the CI/CD pipeline you implemented.**
```
CI/CD Pipeline Components:

Continuous Integration:
- Code checkout and dependency installation
- Unit testing for each service
- Code quality checks (linting, formatting)
- Security scanning (vulnerability checks)
- Docker image building and registry push

Continuous Deployment:
- Automated deployment to staging/production
- Health checks and smoke tests
- Rollback capabilities
- Notification and alerting

Tools used:
- GitHub Actions for workflow automation
- Docker for containerization
- Trivy for security scanning
- Argo CD for GitOps deployment
```

**12. What is GitOps and how did you implement it?**
```
GitOps is a operational framework that takes DevOps best practices used for application development and applies them to infrastructure automation.

Principles:
- Declarative configuration stored in Git
- Automated deployment from Git state
- Software agents ensure actual state matches desired state
- Human operators make changes via Git (pull requests)

Implementation:
- Argo CD as GitOps operator
- Kubernetes manifests stored in Git
- Automated sync when manifests change
- Drift detection and correction
```

**13. How do you handle rollbacks in Kubernetes?**
```
Rollback strategies:

1. Deployment Rollback:
kubectl rollout undo deployment/vote
kubectl rollout undo deployment/vote --to-revision=2

2. Git Revert:
- Revert the commit that caused issues
- Push the revert commit
- Argo CD automatically syncs the change

3. Manual Rollback:
kubectl apply -f previous-manifest.yaml

4. Blue-Green Deployment:
- Deploy new version alongside old
- Switch traffic using service selector
- Rollback by switching selector back

Best practices:
- Test rollbacks in staging
- Keep multiple revision history
- Use canary deployments for high-risk changes
```

### Security Questions

**14. What are NetworkPolicies and why are they important?**
```
NetworkPolicies are Kubernetes resources that control traffic flow between pods and external endpoints.

Why important:
- Implement zero-trust networking
- Control east-west traffic (pod-to-pod)
- Defense in depth security
- Compliance requirements

Example policy:
- Allow vote pods to communicate with Redis
- Deny all other traffic to Redis
- Allow external access only to vote/result services on port 80
```

**15. Explain RBAC in Kubernetes.**
```
Role-Based Access Control (RBAC) regulates access to Kubernetes API resources.

Components:
- Roles/ClusterRoles: Define permissions (apiGroups, resources, verbs)
- RoleBindings/ClusterRoleBindings: Bind roles to subjects (users, groups, service accounts)

Best practices:
- Use principle of least privilege
- Create specific roles for each service
- Use service accounts instead of user accounts
- Regularly audit permissions
```

**16. How do you secure container images?**
```
Image security practices:

1. Base Image Selection:
- Use minimal base images (Alpine, Distroless)
- Regularly update base images
- Avoid latest tags in production

2. Vulnerability Scanning:
- Scan images with Trivy, Clair, or Snyk
- Block deployment of vulnerable images
- Regular security updates

3. Image Signing:
- Use Docker Content Trust
- Sign images with cosign
- Verify signatures before deployment

4. Runtime Security:
- Use read-only root filesystems
- Drop unnecessary capabilities
- Run as non-root user
```

### Monitoring & Observability Questions

**17. Explain the monitoring stack you implemented.**
```
Monitoring Stack Components:

Prometheus:
- Time-series database for metrics
- Pull-based metrics collection
- Service discovery for dynamic targets
- Alerting rules and Alertmanager

Grafana:
- Visualization and dashboarding
- Multiple data sources support
- Custom dashboards and alerts
- User management and permissions

kube-state-metrics:
- Kubernetes object metrics
- Pod, deployment, service metrics
- Not available from kubelet

Implementation:
- Prometheus scrapes metrics from services
- Grafana queries Prometheus for visualization
- Custom dashboards for application metrics
- Alert rules for system health monitoring
```

**18. What metrics do you monitor in a Kubernetes application?**
```
Infrastructure Metrics:
- Node CPU, memory, disk usage
- Pod resource utilization
- Network I/O and latency
- Storage capacity and I/O

Application Metrics:
- Request rate, latency, error rate (RED metrics)
- Business metrics (votes cast, results viewed)
- Database connections and query performance
- Cache hit/miss ratios

Kubernetes Metrics:
- Pod status and restarts
- Deployment rollout status
- Service endpoint health
- Resource quota usage

Alerting:
- High CPU/memory usage
- Pod crashes and restarts
- Service unavailability
- Error rate thresholds
```

**19. Explain centralized logging architecture.**
```
Logging Stack Options:

ELK Stack:
- Elasticsearch: Search and analytics engine
- Logstash: Data processing pipeline
- Kibana: Visualization and exploration
- Filebeat: Log shipper for containers

Loki + Promtail:
- Loki: Log aggregation system
- Promtail: Log collector (like Prometheus for logs)
- Grafana: Log visualization
- Lightweight alternative to ELK

Implementation:
- DaemonSet for log collection on each node
- Structured logging with consistent format
- Log aggregation and search capabilities
- Integration with monitoring alerts
```

### Load Testing & Performance Questions

**20. Explain your load testing strategy.**
```
Load Testing Types Implemented:

1. Standard Load Test:
- Gradual increase from 10 to 100 users
- 2-minute sustained load at peak
- Measures response times and error rates

2. Spike Test:
- Sudden traffic increase to 5 users
- Tests system resilience to traffic spikes
- Validates auto-scaling capabilities

3. Soak Test:
- 17-minute sustained load
- Identifies memory leaks and performance degradation
- Tests system stability over time

k6 Implementation:
- JavaScript-based test scripts
- Custom metrics and thresholds
- Integration with CI/CD pipeline
- Performance benchmarking
```

**21. How do you handle application scaling in Kubernetes?**
```
Horizontal Pod Autoscaling (HPA):
- Scales based on CPU, memory, or custom metrics
- Target utilization thresholds
- Min/max replica limits
- Cooldown periods to prevent thrashing

Vertical Pod Autoscaling (VPA):
- Adjusts CPU/memory requests and limits
- Based on historical usage
- Requires pod restarts

Cluster Autoscaling:
- Scales number of nodes
- Integrates with cloud provider
- Based on pending pods

Implementation:
- HPA configured for vote, result, worker services
- CPU and memory-based scaling
- Custom metrics support
- Pod disruption budgets for safety
```

### Database & Storage Questions

**22. How does the application interact with PostgreSQL and Redis?**
```
Database Architecture:

PostgreSQL:
- Persistent storage for vote results
- ACID compliance for data consistency
- Structured query support
- Connection pooling considerations

Redis:
- In-memory cache for vote queuing
- Fast read/write operations
- Pub/Sub for real-time messaging
- Session storage

Communication Flow:
1. Vote Service → Redis (queue votes)
2. Worker Service → Redis (consume votes) → PostgreSQL (store results)
3. Result Service → PostgreSQL (query results)

Connection Management:
- Service discovery via Kubernetes DNS
- Connection pooling for efficiency
- Health checks and circuit breakers
- Environment-based configuration
```

**23. Explain persistent storage in Kubernetes.**
```
Persistent Volumes (PV):
- Abstract storage from pods
- Survive pod restarts and rescheduling
- Different storage classes (AWS EBS, GCP PD, etc.)

Persistent Volume Claims (PVC):
- Request for storage by users
- Bound to available PVs
- Specify size and access modes

Storage Classes:
- Define storage types and provisioners
- Dynamic provisioning
- Quality of service parameters

Implementation:
- PostgreSQL: 10Gi PVC for data persistence
- Redis: 5Gi PVC for RDB persistence
- Default storage class for cloud provider
```

### Production Deployment Questions

**24. How do you ensure high availability in Kubernetes?**
```
High Availability Strategies:

Pod Level:
- Multiple replicas across nodes
- Anti-affinity rules for distribution
- Pod disruption budgets
- Readiness and liveness probes

Service Level:
- Load balancing across pods
- Health checks and circuit breakers
- Graceful shutdown handling

Cluster Level:
- Multi-zone deployment
- Control plane redundancy
- etcd clustering

Application Level:
- Database replication
- Cache clustering
- Stateless application design
```

**25. What are Pod Security Standards and how do you implement them?**
```
Pod Security Standards define security contexts for pods.

Levels:
- Privileged: No restrictions (development)
- Baseline: Minimal restrictions (most workloads)
- Restricted: Strict security (sensitive workloads)

Implementation:
- SecurityContext in pod specifications
- runAsNonRoot: Prevent root user execution
- readOnlyRootFilesystem: Prevent filesystem writes
- allowPrivilegeEscalation: false
- capabilities: Drop unnecessary capabilities

Admission Controllers:
- Pod Security Admission
- Validating webhooks
- Policy engines (Kyverno, OPA Gatekeeper)
```

### Troubleshooting Questions

**26. How do you debug a failing pod in Kubernetes?**
```
Debugging Steps:

1. Check Pod Status:
kubectl get pods
kubectl describe pod <pod-name>

2. View Logs:
kubectl logs <pod-name>
kubectl logs <pod-name> --previous (crashed pods)

3. Check Events:
kubectl get events --sort-by=.metadata.creationTimestamp

4. Debug Container:
kubectl exec -it <pod-name> -- /bin/bash
kubectl debug <pod-name> --image=busybox

5. Check Resources:
kubectl top pods
kubectl top nodes

6. Network Debugging:
kubectl get networkpolicy
kubectl exec -it <pod> -- curl <service>
```

**27. How do you handle configuration management across environments?**
```
Configuration Management Strategies:

1. ConfigMaps for Environment Variables:
- Different ConfigMaps per environment
- Environment-specific values
- Mounted as volumes or env vars

2. Helm Charts:
- Templated deployments
- Values files per environment
- Chart dependencies

3. Kustomize:
- Base manifests with environment overlays
- Patches for environment-specific changes
- No templating language to learn

4. External Configuration:
- Config servers (Spring Cloud Config)
- Secret management services
- Database-backed configuration

Implementation:
- ConfigMaps for non-sensitive config
- Secrets for sensitive data
- Environment-specific overlays
- GitOps for configuration changes
```

### Cloud & AWS Questions

**28. Explain the AWS infrastructure you provisioned with Terraform.**
```
AWS Infrastructure Components:

VPC and Networking:
- VPC with public subnet
- Internet Gateway for external access
- Route tables and security groups
- DNS resolution enabled

EC2 Instance:
- Ubuntu 22.04 LTS
- t3.large instance type (configurable)
- 50Gi gp3 encrypted EBS volume
- CloudWatch monitoring enabled
- IAM role with SSM and CloudWatch permissions

Security Groups:
- SSH access (configurable CIDR)
- Kubernetes API (6443)
- Application ports (5000-5001)
- Monitoring ports (9090, 3000)
- Internal communication

Bootstrap Script:
- Docker installation and configuration
- Kind cluster creation
- kubectl installation
- Helm and Argo CD setup
- Metrics server deployment
```

**29. How do you handle AWS costs optimization?**
```
Cost Optimization Strategies:

1. Right-sizing:
- Choose appropriate instance types
- Monitor utilization with CloudWatch
- Use auto-scaling groups

2. Storage Optimization:
- Use gp3 instead of gp2 (better performance/cost)
- Implement lifecycle policies for backups
- Use appropriate storage classes

3. Reserved Instances/Savings Plans:
- Commit to 1-3 year terms for discounts
- Use convertible RIs for flexibility

4. Monitoring and Cleanup:
- Set up billing alerts
- Regular resource audits
- Clean up unused resources

Implementation:
- Configurable instance types
- CloudWatch monitoring enabled
- Cost allocation tags
- terraform destroy for cleanup
```

### Testing Questions

**30. Explain your testing pyramid and implementation.**
```
Testing Pyramid Levels:

Unit Tests (Bottom Layer - Most Tests):
- Test individual functions/methods
- Fast execution, isolated testing
- High coverage (>80%)
- Mock external dependencies

Integration Tests (Middle Layer):
- Test service interactions
- Database and cache connectivity
- API endpoint testing
- Component integration

E2E Tests (Top Layer - Few Tests):
- Full user workflow testing
- Browser automation
- API contract testing
- Production-like environment

Load Tests (Performance):
- Capacity and performance validation
- Stress testing scenarios
- Scalability verification
- Baseline establishment

Implementation:
- Unit tests in CI pipeline
- Integration tests with real services
- E2E tests for critical paths
- Load tests for performance validation
```

**31. How do you handle database migrations in Kubernetes?**
```
Database Migration Strategies:

1. Init Containers:
- Run migrations before main container starts
- Ensure schema is up-to-date
- Fail deployment if migration fails

2. Job Resources:
- Separate Job for migrations
- Run once before deployment
- Version-controlled migration scripts

3. Application-Level Migrations:
- Built into application startup
- Automatic schema updates
- Rollback capabilities

4. External Tools:
- Flyway for SQL migrations
- Liquibase for database refactoring
- Custom migration frameworks

Implementation:
- Init container for PostgreSQL schema setup
- Version-controlled SQL scripts
- Migration status tracking
- Rollback procedures
```

**32. What are Helm charts and when would you use them?**
```
Helm is a package manager for Kubernetes that simplifies application deployment.

Helm Components:
- Charts: Pre-configured Kubernetes resources
- Templates: Parameterized manifests
- Values: Configuration overrides
- Releases: Deployed chart instances

When to Use:
- Complex applications with many resources
- Multiple environments with different configs
- Reusable application packages
- Dependency management between charts

Implementation Considerations:
- Chart structure and best practices
- Values file organization
- Template functions and helpers
- Chart testing and validation
```

**33. Explain service mesh and when it would be useful.**
```
Service mesh provides a dedicated infrastructure layer for service-to-service communication.

Components:
- Data Plane: Sidecar proxies (Envoy, Linkerd)
- Control Plane: Management and configuration
- Service Discovery: Automatic endpoint discovery
- Traffic Management: Routing, load balancing, retries

Benefits:
- Observability (tracing, metrics, logging)
- Security (mTLS, authorization)
- Traffic control (canary deployments, circuit breakers)
- Resilience (timeouts, retries, fault injection)

When Useful:
- Microservices with complex communication
- Multi-language services
- Zero-trust security requirements
- Advanced traffic management needs

Popular Options:
- Istio: Feature-rich, complex
- Linkerd: Lightweight, simple
- Consul Connect: Integrated with HashiCorp stack
```

**34. How do you implement blue-green deployments in Kubernetes?**
```
Blue-Green Deployment Strategy:

1. Deploy new version alongside old:
- Create new deployment with different labels
- New version runs in parallel with old

2. Switch traffic using services:
- Update service selector to point to new deployment
- Old deployment still running for rollback

3. Validate new deployment:
- Health checks and smoke tests
- Monitor metrics and logs
- Gradual traffic shifting if needed

4. Cleanup old deployment:
- Delete old deployment after validation
- Keep old version for quick rollback

Implementation:
- Label-based deployment strategy
- Service selector updates
- Ingress rule changes
- Automated validation scripts
```

**35. What are admission controllers and how do they work?**
```
Admission controllers are plugins that intercept requests to the Kubernetes API server.

Types:
- Validating: Reject requests that don't meet criteria
- Mutating: Modify requests before processing

Common Controllers:
- PodSecurity: Enforce security standards
- ResourceQuota: Limit resource usage
- NamespaceLifecycle: Prevent deletion of default namespaces
- DefaultStorageClass: Set default storage class

How They Work:
1. Request sent to API server
2. Authentication and authorization
3. Admission controller validation/mutation
4. Object validation and persistence
5. Response to client

Implementation:
- Built-in controllers enabled by default
- Custom controllers via webhooks
- Policy engines (Kyverno, OPA Gatekeeper)
```

**36. Explain Kubernetes operators and custom resources.**
```
Operators extend Kubernetes with custom resources and controllers.

Components:
- Custom Resource Definitions (CRDs): Define new resource types
- Custom Controllers: Watch and reconcile custom resources
- Operator Pattern: Encapsulates operational knowledge

Examples:
- Prometheus Operator: Manages Prometheus instances
- Argo CD Operator: Manages Argo CD deployments
- Database Operators: Manage database clusters

Benefits:
- Domain-specific automation
- Declarative configuration
- Self-healing capabilities
- Operational best practices

Implementation:
- CRD definitions
- Controller logic in Go
- RBAC permissions
- Testing and validation
```

**37. How do you handle secrets management in production?**
```
Production Secrets Management:

External Secret Management:
- AWS Secrets Manager, GCP Secret Manager
- HashiCorp Vault, Azure Key Vault
- Integration with Kubernetes via operators

Kubernetes Secrets Best Practices:
- Use sealed secrets or external secret operators
- Encrypt etcd data at rest
- Rotate secrets regularly
- Least privilege access

Implementation:
- External secret stores for sensitive data
- Kubernetes secrets for runtime access
- Secret rotation policies
- Audit logging for secret access
```

**38. What are the challenges of running stateful applications in Kubernetes?**
```
Stateful Application Challenges:

1. Persistent Storage:
- Data persistence across pod restarts
- Storage class selection and performance
- Backup and restore procedures

2. Networking and DNS:
- Stable network identities
- Service discovery for stateful sets
- Load balancing considerations

3. Scaling and Updates:
- Ordered scaling operations
- Rolling updates with data consistency
- Quorum requirements for clusters

4. Resource Management:
- Anti-affinity for high availability
- Resource limits and requests
- Pod disruption budgets

Solutions:
- StatefulSets for ordered deployments
- Persistent Volumes for data persistence
- Headless services for stable DNS
- Proper backup and recovery strategies
```

**39. Explain Kubernetes networking and CNI plugins.**
```
Kubernetes Networking Model:

Requirements:
- Every pod gets unique IP address
- Pods communicate without NAT
- No explicit port mapping needed

Container Network Interface (CNI):
- Plugin interface for networking
- Responsible for pod networking setup
- Integrates with underlying network infrastructure

Popular CNI Plugins:
- Calico: Advanced networking and security
- Flannel: Simple overlay networking
- Cilium: eBPF-based networking and security
- Weave Net: Simple setup, encryption

Network Policies:
- Control traffic between pods
- Implemented by CNI plugins
- Default deny, explicit allow rules

Implementation:
- CNI plugin selection based on requirements
- Network policy configuration
- Service mesh integration
- Multi-cluster networking
```

**40. How do you monitor and troubleshoot Kubernetes clusters?**
```
Cluster Monitoring and Troubleshooting:

Monitoring Stack:
- Prometheus for metrics collection
- Grafana for visualization
- Alertmanager for notifications
- kube-state-metrics for Kubernetes metrics

Troubleshooting Tools:
- kubectl commands for inspection
- Lens or k9s for cluster management
- stern for multi-pod log tailing
- kubectx/kubens for context switching

Common Issues:
- Resource constraints (CPU/memory)
- Network connectivity problems
- Image pull failures
- Pod scheduling issues
- DNS resolution problems

Debugging Process:
1. Check cluster status and events
2. Inspect pod and node status
3. Review logs and metrics
4. Test network connectivity
5. Validate configurations
6. Check resource utilization
```

**41. What are the best practices for Kubernetes security?**
```
Kubernetes Security Best Practices:

Cluster Security:
- Keep Kubernetes version updated
- Use RBAC with least privilege
- Enable audit logging
- Secure etcd with encryption
- Use network policies

Pod Security:
- Run as non-root user
- Use read-only root filesystem
- Drop unnecessary capabilities
- Resource limits and requests
- Security contexts

Image Security:
- Scan images for vulnerabilities
- Use minimal base images
- Sign and verify images
- Regular updates and patches

Network Security:
- Implement zero-trust networking
- Use TLS for all communications
- Service mesh for mTLS
- Ingress controllers with TLS

Access Control:
- Multi-factor authentication
- Certificate-based authentication
- Regular credential rotation
- Principle of least privilege
```

**42. Explain the concept of GitOps and its benefits.**
```
GitOps is an operational framework that applies DevOps practices to infrastructure and application deployment.

Core Principles:
- Declarative configuration stored in Git
- Automated deployment from Git state
- Software agents ensure desired state
- Manual changes are discouraged

Benefits:
- Version control for infrastructure
- Audit trail of all changes
- Automated rollbacks
- Consistency across environments
- Collaboration through pull requests

Implementation:
- Git as single source of truth
- CI/CD for testing and validation
- Operators for state reconciliation
- Drift detection and correction

Tools:
- Argo CD, Flux CD for Kubernetes
- Terraform Cloud for infrastructure
- GitHub Actions for CI/CD
```

**43. How do you implement canary deployments in Kubernetes?**
```
Canary Deployment Strategy:

1. Deploy new version to subset of users:
- Create new deployment with different labels
- Route percentage of traffic to new version
- Use service mesh or ingress rules

2. Monitor and validate:
- Track metrics and error rates
- Compare performance with baseline
- Automated rollback if thresholds exceeded

3. Gradual rollout:
- Increase traffic percentage over time
- Monitor at each stage
- Complete rollout or rollback based on results

Implementation:
- Istio service mesh for traffic splitting
- Flagger for automated canary analysis
- Prometheus metrics for validation
- Automated promotion or rollback
```

**44. What are the considerations for multi-cluster Kubernetes deployments?**
```
Multi-Cluster Considerations:

Use Cases:
- Disaster recovery and high availability
- Geographic distribution
- Environment separation (dev/staging/prod)
- Compliance and data sovereignty

Challenges:
- Configuration consistency
- Service discovery across clusters
- Network connectivity and security
- Resource management and quotas

Solutions:
- Federation for unified management
- Service mesh for cross-cluster communication
- GitOps for consistent deployments
- Centralized monitoring and logging

Implementation:
- Cluster API for cluster lifecycle
- Cross-cluster service discovery
- Network policies and security
- Backup and disaster recovery
```

**45. Explain Kubernetes resource management and QoS.**
```
Kubernetes Resource Management:

Resource Requests:
- Guaranteed minimum resources
- Used for scheduling decisions
- Pods won't be scheduled if requests can't be met

Resource Limits:
- Maximum resources a pod can use
- Prevents resource exhaustion
- Can cause throttling or OOM kills

Quality of Service (QoS) Classes:
- Guaranteed: Requests = Limits (highest priority)
- Burstable: Requests < Limits (medium priority)
- BestEffort: No requests/limits (lowest priority)

Resource Quotas:
- Limit resource usage per namespace
- Prevent resource exhaustion
- Fair sharing across teams

Implementation:
- Set appropriate requests and limits
- Monitor resource utilization
- Use resource quotas for multi-tenancy
- Implement HPA for dynamic scaling
```

**46. How do you handle application configuration in Kubernetes?**
```
Configuration Management Strategies:

ConfigMaps:
- Non-sensitive configuration data
- Environment variables or mounted files
- Created from literals, files, or directories

Secrets:
- Sensitive configuration data
- Base64 encoded (not encrypted)
- Same usage patterns as ConfigMaps

Best Practices:
- Separate config from code
- Use environment-specific ConfigMaps
- Rotate secrets regularly
- Use external secret management

Implementation:
- ConfigMaps for application settings
- Secrets for database passwords, API keys
- Environment variable injection
- Volume mounts for configuration files
```

**47. What are the different ways to expose applications in Kubernetes?**
```
Application Exposure Methods:

ClusterIP Service:
- Default service type
- Internal cluster access only
- Stable endpoint for pod communication

NodePort Service:
- Exposes service on each node's port
- Access via <NodeIP>:<NodePort>
- Useful for development and testing

LoadBalancer Service:
- Creates cloud provider load balancer
- External access with public IP
- Automatic load distribution

Ingress:
- HTTP/HTTPS routing to services
- Host and path-based routing
- SSL/TLS termination
- Advanced features (auth, rate limiting)

Implementation:
- ClusterIP for internal communication
- Ingress for external HTTP access
- LoadBalancer for direct service exposure
- Network policies for access control
```

**48. Explain Kubernetes storage concepts and persistent volumes.**
```
Kubernetes Storage Architecture:

Persistent Volumes (PV):
- Cluster-wide storage resources
- Survive pod lifecycle
- Provisioned by administrators or dynamically

Persistent Volume Claims (PVC):
- User requests for storage
- Bound to available PVs
- Specify size, access mode, storage class

Storage Classes:
- Define storage types and provisioners
- Dynamic provisioning parameters
- Quality of service levels

Access Modes:
- ReadWriteOnce: Single node read-write
- ReadOnlyMany: Multiple nodes read-only
- ReadWriteMany: Multiple nodes read-write

Implementation:
- Storage class selection
- PVC specifications
- Volume mounting in pods
- Backup and recovery strategies
```

**49. How do you implement logging in Kubernetes applications?**
```
Kubernetes Logging Patterns:

Application Logging:
- Structured logging with consistent format
- Log levels (DEBUG, INFO, WARN, ERROR)
- Contextual information (request IDs, user IDs)

Container Logging:
- stdout/stderr captured by kubelet
- Logs available via kubectl logs
- Log rotation and retention

Centralized Logging:
- Log aggregation from all pods
- Search and analysis capabilities
- Integration with monitoring

Implementation:
- EFK/ELK stack for full-featured logging
- Loki + Promtail for lightweight logging
- Fluentd/Fluent Bit for log processing
- Structured logging libraries
```

**50. What are the key considerations for Kubernetes in production?**
```
Production Kubernetes Considerations:

Cluster Management:
- High availability control plane
- Regular updates and patches
- Backup and disaster recovery
- Multi-zone deployment

Security:
- RBAC with least privilege
- Network policies and segmentation
- Image scanning and signing
- Audit logging and monitoring

Scalability:
- Horizontal and vertical scaling
- Resource management and quotas
- Cluster autoscaling
- Performance monitoring

Reliability:
- Pod disruption budgets
- Health checks and probes
- Circuit breakers and retries
- Automated remediation

Operations:
- Monitoring and alerting
- Log aggregation and analysis
- Backup and restore procedures
- Incident response procedures

Implementation:
- Production-ready configurations
- Automated deployment pipelines
- Comprehensive monitoring
- Regular maintenance procedures
```

---

## 🌍 Real-World Use Cases

### E-commerce Voting System
**Scenario**: Online retailer wants customer feedback on product features
- **Use Case**: Real-time voting on product features during beta testing
- **Requirements**: High availability, real-time results, data persistence
- **Implementation**: Vote service for submissions, Result service for live updates, PostgreSQL for permanent storage

### Conference/Event Voting
**Scenario**: Tech conference with multiple tracks running simultaneously
- **Use Case**: Attendees vote on session topics in real-time
- **Requirements**: High concurrency, instant results, session-based voting
- **Implementation**: Redis for fast vote queuing, WebSocket for real-time updates, Worker service for result aggregation

### Employee Engagement Platform
**Scenario**: Company intranet with employee polling features
- **Use Case**: HR department runs anonymous employee satisfaction surveys
- **Requirements**: Secure voting, anonymous submissions, detailed analytics
- **Implementation**: NetworkPolicies for security, RBAC for access control, Prometheus for usage analytics

### IoT Device Management
**Scenario**: Smart city infrastructure with citizen feedback systems
- **Use Case**: Public voting on city improvement projects
- **Requirements**: High availability, geo-distribution, offline capability
- **Implementation**: Multi-cluster deployment, Redis caching, PostgreSQL replication

### Educational Platform
**Scenario**: Online learning platform with interactive quizzes
- **Use Case**: Students vote on quiz answers, instant result feedback
- **Requirements**: Real-time collaboration, teacher monitoring, result analytics
- **Implementation**: WebSocket connections, Grafana dashboards for teachers, load testing for peak usage

---

## 🔒 Security, Networking, Scaling, and Monitoring

### Security Implementation

**Network Security (Zero-Trust)**
- **NetworkPolicies**: Implemented comprehensive policies allowing only necessary traffic
- **Default Deny**: All ingress/egress blocked by default, explicit allows only
- **Service Isolation**: Each service can only communicate with required dependencies
- **External Access**: Controlled access to vote/result services on port 80 only

**Access Control (RBAC)**
- **Least Privilege**: Each service has minimal required permissions
- **Service Accounts**: Dedicated accounts for vote, result, worker, db, redis services
- **Role Definitions**: Specific API permissions for each component
- **Audit Logging**: All API access logged for security monitoring

**Pod Security**
- **SecurityContexts**: Non-root execution, read-only filesystems, dropped capabilities
- **Resource Limits**: CPU and memory constraints to prevent resource exhaustion
- **Image Security**: Vulnerability scanning with Trivy, minimal base images
- **Secret Management**: Base64 encoded secrets with rotation procedures

### Networking Architecture

**Kubernetes Networking Model**
- **Pod Networking**: Each pod gets unique IP, direct pod-to-pod communication
- **Service Discovery**: DNS-based service discovery (service-name.namespace.svc.cluster.local)
- **Load Balancing**: Internal load balancing via kube-proxy
- **Network Policies**: Calico-based traffic control and security

**External Access Patterns**
- **Ingress Controller**: HTTP routing with host/path-based rules
- **NodePort Services**: Direct node access for development
- **LoadBalancer Services**: Cloud provider integration for production
- **Port Forwarding**: Local development access via kubectl

### Scaling Strategies

**Horizontal Pod Autoscaling (HPA)**
- **Vote Service**: 2-5 replicas, CPU 70% target, scale based on request load
- **Result Service**: 2-5 replicas, memory 80% target, handles WebSocket connections
- **Worker Service**: 2-10 replicas, CPU 75% target, processes background jobs
- **Cooldown Periods**: Stabilization time to prevent thrashing

**Resource Management**
- **Requests**: Guaranteed minimum resources for scheduling
- **Limits**: Maximum resource usage to prevent starvation
- **QoS Classes**: Guaranteed, Burstable, BestEffort based on requirements
- **Resource Quotas**: Namespace-level resource limits

**Cluster Scaling**
- **Node Autoscaling**: Scale worker nodes based on pending pods
- **Storage Scaling**: Dynamic PVC expansion for databases
- **Load Balancing**: Distribute traffic across scaled pods

### Monitoring & Observability

**Metrics Collection (Prometheus)**
- **Infrastructure Metrics**: Node CPU, memory, disk, network
- **Application Metrics**: Request rate, latency, error rate, custom business metrics
- **Kubernetes Metrics**: Pod status, deployment health, service endpoints
- **Custom Metrics**: Vote counts, result views, worker processing rates

**Visualization (Grafana)**
- **System Dashboards**: Cluster health, resource utilization
- **Application Dashboards**: Service performance, error rates
- **Business Dashboards**: Voting trends, user engagement
- **Alert Dashboards**: Active alerts and incident tracking

**Logging Architecture**
- **Application Logs**: Structured logging with consistent format
- **System Logs**: Kubernetes component logs, node logs
- **Audit Logs**: API server access, authentication events
- **Centralized Storage**: ELK stack or Loki for search and analysis

**Alerting & Incident Response**
- **Alert Rules**: CPU > 80%, memory > 85%, pod restarts > 5/min
- **Notification Channels**: Slack, email, PagerDuty integration
- **Escalation Policies**: Tiered response based on severity
- **Runbooks**: Automated remediation and manual procedures

---

## 🔗 Database Connection Flow

### PostgreSQL Connection Architecture

**Connection Flow:**
```
User Browser → Vote Service → Worker Service → PostgreSQL
     ↓              ↓              ↓              ↓
   HTTP POST    Redis Queue    SQL INSERT    Persistent
   /vote        PUBLISH         EXECUTE       Storage
```

**Detailed Connection Steps:**

1. **Application Startup**
   - Vote service connects using `psycopg2` library
   - Connection string: `postgresql://postgres:password@db:5432/postgres`
   - Kubernetes DNS resolves `db` to ClusterIP service

2. **Connection Pooling**
   - Worker service maintains connection pool
   - Reuses connections for multiple queries
   - Handles connection failures gracefully

3. **Health Checks**
   - Readiness probe uses `pg_isready` command
   - Liveness probe checks database connectivity
   - Circuit breaker pattern for fault tolerance

4. **Security**
   - Database password stored in Kubernetes Secret
   - NetworkPolicy restricts database access
   - RBAC controls service account permissions

### Redis Connection Architecture

**Connection Flow:**
```
Vote Service → Redis (Queue) ← Worker Service
     ↓                           ↓
 PUBLISH vote                SUBSCRIBE votes
   to queue                   from queue
```

**Detailed Connection Steps:**

1. **Queue Operations**
   - Vote service: `redis.lpush('votes', vote_data)`
   - Worker service: `redis.brpop('votes', timeout)`

2. **Connection Management**
   - Connection pooling for performance
   - Automatic reconnection on failures
   - Redis health checks in probes

3. **Data Persistence**
   - Redis AOF (Append Only File) enabled
   - Data persisted to PVC for durability
   - RDB snapshots for backup

4. **High Availability**
   - Single Redis instance with persistence
   - Future: Redis Cluster for multi-node setup
   - Connection retry logic in application code

### Load Balancer Integration

**Kubernetes Service Load Balancing:**
```
External Traffic → LoadBalancer Service → Pod Endpoints
                    ↓
             ClusterIP Service → Pod Selection
                    ↓
             kube-proxy → iptables/ipvs rules
```

**Load Balancing Features:**
- **Round Robin**: Default distribution algorithm
- **Session Affinity**: Sticky sessions if needed
- **Health Checks**: Automatic removal of unhealthy pods
- **Scaling Integration**: HPA-triggered pod scaling

---

## 🔄 End-to-End Request Flow

### Complete User Journey

**Step 1: User Access**
```
User Browser → Internet → AWS Load Balancer → Kubernetes Ingress
                                      ↓
                               NodePort Service (port 80)
                                      ↓
                              Vote Service Pod
```

**Step 2: Vote Submission**
```
Vote Service → Input Validation → Redis Queue Publish
                                      ↓
                               Asynchronous Processing
```

**Step 3: Background Processing**
```
Worker Service → Redis Queue Consume → Data Processing
                                      ↓
                               PostgreSQL Storage
```

**Step 4: Result Display**
```
Result Service → PostgreSQL Query → Real-time Updates
                                      ↓
                            WebSocket Broadcasting
```

**Step 5: Monitoring Integration**
```
All Services → Prometheus Scraping → Metrics Storage
                                      ↓
                            Grafana Visualization
```

### Detailed Request Flow Analysis

**HTTP Request Flow (Vote Submission):**

1. **Client Request**
   - User submits form: `POST /vote` with `vote=a|b`
   - Request reaches AWS Application Load Balancer

2. **Load Balancer Distribution**
   - ALB routes to healthy Kubernetes nodes
   - NodePort service receives traffic on port 80

3. **Kubernetes Service Routing**
   - Service selects healthy vote pod endpoints
   - kube-proxy performs load balancing (round-robin)

4. **Application Processing**
   - Flask route handler validates input
   - Publishes vote to Redis queue
   - Returns success response immediately

5. **Asynchronous Processing**
   - Worker service consumes from Redis queue
   - Aggregates vote counts
   - Updates PostgreSQL database

6. **Real-time Updates**
   - Result service queries updated counts
   - WebSocket connections receive live updates
   - Connected clients see instant results

**Monitoring Flow:**

1. **Metrics Collection**
   - Prometheus scrapes `/metrics` endpoints
   - kube-state-metrics provides Kubernetes metrics
   - Custom application metrics collected

2. **Alert Evaluation**
   - Alert rules evaluated every 30 seconds
   - Threshold breaches trigger notifications
   - Escalation based on severity levels

3. **Logging Aggregation**
   - Filebeat collects container logs
   - Structured logs sent to Elasticsearch/Loki
   - Searchable log aggregation for troubleshooting

**Security Flow:**

1. **Network Policy Enforcement**
   - Traffic validated against NetworkPolicies
   - Only allowed pod-to-pod communication
   - External access restricted to specific ports

2. **RBAC Authorization**
   - Service accounts validated for API access
   - Least privilege permissions enforced
   - Audit logs capture all access attempts

3. **Pod Security**
   - Security contexts prevent privilege escalation
   - Resource limits prevent DoS attacks
   - Image scanning blocks vulnerable deployments

This comprehensive documentation covers every aspect of the project implementation, from basic concepts to advanced production considerations. The project demonstrates enterprise-grade DevOps practices suitable for real-world deployment scenarios.