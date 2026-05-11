# GitHub Actions Secrets Setup

To use the CI/CD pipelines, configure these secrets in your GitHub repository:

## Required Secrets

### Container Registry
- **GITHUB_TOKEN**: Auto-provided by GitHub Actions (no setup needed)

### Kubernetes Deployment
- **KUBE_CONFIG**: Base64-encoded kubeconfig file
  ```bash
  cat ~/.kube/config | base64 | tr -d '\n'
  ```

### Argo CD
- **ARGOCD_SERVER**: Argo CD server URL (e.g., https://argocd.example.com)
- **ARGOCD_USERNAME**: Argo CD username
- **ARGOCD_PASSWORD**: Argo CD password

### Security Scanning
- **SNYK_TOKEN**: Token from https://snyk.io (optional)
- **SONARCLOUD_TOKEN**: Token from https://sonarcloud.io (optional)

### Notifications
- **SLACK_WEBHOOK**: Slack webhook URL for deployment notifications (optional)

### Renovate (Dependency Updates)
- **RENOVATE_TOKEN**: GitHub personal access token with repo permissions

## Setup Steps

1. Go to repository Settings → Secrets and variables → Actions
2. Click "New repository secret"
3. Add each secret name and value
4. Save

## Testing Secrets

To verify secrets are properly configured:
```bash
gh secret list
```

## Security Best Practices

- Use organization-level secrets when possible
- Rotate tokens regularly
- Use minimal required permissions
- Never commit secrets to the repository
- Use GitHub's built-in secret scanning
