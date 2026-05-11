# GitHub Actions CI/CD Setup Documentation

## Overview

This directory contains GitHub Actions workflows to automate:
- **Building and pushing Docker images** to container registry
- **Running tests** (unit, integration, security)
- **Deploying to Kubernetes** via Argo CD
- **Code quality checks** (SonarCloud, TFLint)
- **Dependency updates** (Renovate)

## Workflows

### 1. Build and Push Images (build-push-images.yml)
Triggered on:
- Push to `main` or `develop` branches (when service code changes)
- Pull requests to `main` or `develop`

Steps:
1. Builds Docker images for vote, result, and worker services
2. Pushes to GitHub Container Registry (GHCR)
3. Runs Trivy vulnerability scan on each image
4. Uploads SARIF reports for GitHub Security tab

**Outputs**: Docker images tagged with branch/commit SHA

### 2. Deploy to Kubernetes (deploy.yml)
Triggered on:
- Push to `main` branch with changes to k8s-specifications
- Successful completion of build-push-images workflow

Steps:
1. Validates Kubernetes manifests with `kubectl --dry-run`
2. Applies manifests to the cluster
3. Waits for deployments to be ready (5-minute timeout)
4. Creates/syncs Argo CD application
5. Sends Slack notification (optional)

**Requires**: KUBE_CONFIG and ARGOCD_* secrets

### 3. Testing (testing.yml)
Triggered on:
- Push to `main` or `develop`
- Pull requests to `main` or `develop`

Includes:
- **Unit tests**: Result service (Node.js)
- **Integration tests**: Vote service with PostgreSQL and Redis
- **Dockerfile linting**: Hadolint checks for best practices
- **Security scans**: Snyk and OWASP Dependency-Check

**Uploads**: Coverage reports to Codecov, security reports to GitHub

### 4. Code Quality (code-quality.yml)
Triggered on:
- Push to `main` or `develop`
- Pull requests to `main` or `develop`

Checks:
- **SonarCloud**: Code quality and coverage analysis
- **Renovate**: Automated dependency updates
- **TFLint**: Terraform best practices
- **Markdown Lint**: Documentation quality

**Requires**: SONARCLOUD_TOKEN secret (optional)

## Setup Instructions

### 1. Enable GitHub Actions
Go to repository Settings → Actions → Permissions → Allow all actions and reusable workflows

### 2. Configure Secrets
See [.github/SECRETS_SETUP.md](SECRETS_SETUP.md) for detailed setup

Required secrets:
```
KUBE_CONFIG (base64 kubeconfig)
ARGOCD_SERVER
ARGOCD_USERNAME
ARGOCD_PASSWORD
SLACK_WEBHOOK (optional)
SNYK_TOKEN (optional)
SONARCLOUD_TOKEN (optional)
```

### 3. Create GitHub App (for Renovate)
1. Go to Settings → Developer settings → GitHub Apps
2. Create a new app with repo access
3. Generate a personal access token or use GitHub App token

### 4. Verify Workflows
- Push a commit to `main` or `develop`
- Check Actions tab to see workflows running
- Verify all steps pass

## Common Issues

### Build fails with authentication error
- Verify GITHUB_TOKEN is available (auto-provided)
- Check GHCR login credentials

### Deployment fails
- Verify KUBE_CONFIG secret is properly base64-encoded
- Check kubectl can reach the cluster: `kubectl cluster-info`
- Verify Argo CD is installed and running

### Slack notifications not sent
- SLACK_WEBHOOK is optional; omit for no notifications
- Verify webhook URL is valid

### Renovate not creating PRs
- Check Renovate token has proper permissions
- Check renovate.json is valid JSON
- Review Renovate logs in Actions tab

## Customization

### Add custom tests
Edit `testing.yml` to add test commands for your services

### Change deployment target
Update ARGOCD_SERVER and KUBE_CONFIG for different clusters

### Modify schedule
Change cron expressions in workflow triggers

### Add notifications
Add other notification actions (e.g., PagerDuty, OpsGenie)

## Monitoring

View workflow runs:
- GitHub Actions tab in repository
- Each workflow shows detailed logs
- Failed jobs have clear error messages

Set up notifications:
- Enable GitHub Notifications for workflow failures
- Configure Slack/email notifications via secrets
