# Kubernetes Security Best Practices

This document outlines the security enhancements implemented for the voting app.

## Security Features Implemented

### 1. Network Policies

**Location**: `network-policies.yaml`

NetworkPolicies control traffic between pods at the network layer:

#### Default Deny
- All ingress traffic denied by default
- All egress traffic denied by default
- Services must explicitly allow required traffic

#### Allowed Traffic Paths
```
Vote Service → Redis, Database
Result Service → Database
Worker Service → Redis, Database
External → Vote Service (port 80)
External → Result Service (port 80)
All pods → DNS (port 53)
```

**Benefits:**
- Prevents lateral movement if a container is compromised
- Reduces attack surface
- Forces explicit trust relationships

**Troubleshooting:**
If pods can't communicate:
1. Check NetworkPolicy rules with: `kubectl get networkpolicies`
2. Test connectivity: `kubectl exec <pod> -- nc -zv <service> <port>`
3. Verify DNS resolution: `kubectl exec <pod> -- nslookup <service>`

### 2. RBAC (Role-Based Access Control)

**Location**: `rbac.yaml`

RBAC controls what Kubernetes API resources each ServiceAccount can access:

#### Roles Created
- `vote-role`: Read ConfigMaps and DB secrets
- `result-role`: Read ConfigMaps and DB secrets
- `worker-role`: Read ConfigMaps and DB secrets
- `db-role`: Read ConfigMaps and DB secrets
- `redis-role`: Read ConfigMaps

**Principle of Least Privilege:**
- Each service has its own ServiceAccount
- Permissions limited to only required resources
- Cannot delete, create, or modify cluster resources

**Verification:**
```bash
# Check permissions for a service account
kubectl auth can-i get secrets --as=system:serviceaccount:default:vote

# List roles
kubectl get roles

# View role details
kubectl describe role vote-role
```

### 3. Security Context

**Location**: All deployment files

SecurityContext enforces container security policies:

#### Applied Settings
- **runAsNonRoot**: Containers run as unprivileged users (where supported)
- **readOnlyRootFilesystem**: Root filesystem is read-only (where compatible)
- **allowPrivilegeEscalation**: Disabled (prevents privilege escalation)
- **capabilities**: Drop ALL Linux capabilities, add only required ones
- **fsGroup**: Set filesystem group ownership

**Example (Database):**
```yaml
securityContext:
  runAsNonRoot: true
  runAsUser: 999
  fsGroup: 999
  allowPrivilegeEscalation: false
  capabilities:
    drop:
      - ALL
```

**Benefits:**
- Limits damage if container is compromised
- Prevents privilege escalation attacks
- Enforces least privilege principle

### 4. Secrets Management

**Location**: `secrets-config.yaml`

#### Current Implementation
- Database passwords stored in Kubernetes Secrets
- ConfigMaps for non-sensitive configuration
- Base64 encoding (NOT encryption at rest)

#### Production Recommendations
1. **Enable Encryption at Rest**: Configure etcd encryption
   ```bash
   # Enable encryption in cluster configuration
   ```

2. **Use External Secrets Operator**: Integrate with AWS Secrets Manager, HashiCorp Vault
   ```yaml
   apiVersion: external-secrets.io/v1beta1
   kind: SecretStore
   metadata:
     name: aws-secrets
   spec:
     provider:
       aws:
         service: SecretsManager
   ```

3. **Rotate Credentials Regularly**: Implement automatic rotation

4. **Audit Secret Access**: Enable audit logging for secret access

#### Current Process
```bash
# Create secret
kubectl create secret generic db-secret --from-literal=password=<secure-password>

# Verify secret created
kubectl get secrets

# Never expose secrets in logs
kubectl logs <pod>  # Safe (pods read from secrets via env vars)
kubectl get secret db-secret -o yaml  # CAUTION: Displays decoded values!
```

### 5. Pod Security Standards (PSS)

**Location**: Deployment files

The cluster can enforce Pod Security Standards at the namespace level.

**Recommended Policy for `default` namespace:**
```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: default
  labels:
    pod-security.kubernetes.io/enforce: baseline
    pod-security.kubernetes.io/audit: restricted
    pod-security.kubernetes.io/warn: restricted
```

**Standards:**
- **Privileged**: No restrictions (avoid in production)
- **Baseline**: Prevents known privilege escalations
- **Restricted**: Enforces security best practices

### 6. Image Security

**Implemented:**
- **ImagePullPolicy: IfNotPresent**: Use cached images when available
- **Specific tags**: Use specific versions, not `latest`
- **Vulnerability scanning**: GitHub Actions runs Trivy scans

**Recommendations:**
1. Use private image registries
2. Sign images with Cosign
3. Scan images regularly with Trivy/Snyk
4. Implement admission controllers (e.g., Kyverno) to block unsigned images

### 7. Network Security

**Implemented:**
- NetworkPolicies restrict pod-to-pod traffic
- Ingress controlled via services
- No privileged ports exposed

**Additional Measures:**
1. Use Istio or Linkerd for mTLS between services
2. Implement service mesh policies
3. Enable network segmentation with namespaces

### 8. Audit Logging

**Enable API Audit Logging:**
```yaml
# In cluster configuration
auditPolicy:
  - level: RequestResponse
    verbs: ["create", "update", "patch", "delete"]
    resources: ["secrets", "clusterrolebindings"]
```

**Monitor:**
- Secret access and creation
- RBAC changes
- Pod creation in production namespaces

## Security Checklist

- [x] Network policies enforce zero-trust
- [x] RBAC implemented with least privilege
- [x] Security contexts limit pod capabilities
- [x] Secrets stored encrypted at rest (config only)
- [x] Non-root users where possible
- [x] Read-only root filesystem where applicable
- [x] Container image scanning enabled
- [ ] Encryption at rest enabled (PLAN: enable etcd encryption)
- [ ] mTLS between services (PLAN: install Istio)
- [ ] Admission controllers (PLAN: implement Kyverno)
- [ ] Pod Security Policy enforced (PLAN: enable PSP/PSS)
- [ ] Regular vulnerability scans (PLAN: add scheduled scans)
- [ ] Secret rotation (PLAN: implement automation)
- [ ] Audit logging (PLAN: enable audit)

## Deployment Order for Security

```bash
# 1. Apply RBAC first (before services access API)
kubectl apply -f rbac.yaml

# 2. Apply NetworkPolicies (before starting workloads)
kubectl apply -f network-policies.yaml

# 3. Create secrets securely
kubectl create secret generic db-secret --from-literal=password=$(openssl rand -base64 32)

# 4. Apply remaining manifests
kubectl apply -f .
```

## Testing Security Policies

### Test Network Policies
```bash
# Verify vote pod can reach redis
kubectl exec -it <vote-pod> -- nc -zv redis 6379

# Verify vote pod CANNOT reach result pod
kubectl exec -it <vote-pod> -- nc -zv result 80
# Should fail

# Verify external access to vote service
curl http://<vote-service-ip>:5000
```

### Test RBAC
```bash
# Check what vote service account can do
kubectl auth can-i get secrets --as=system:serviceaccount:default:vote

# Try to delete deployment (should fail)
kubectl auth can-i delete deployment --as=system:serviceaccount:default:vote
# No
```

### Test Security Context
```bash
# Check pod runs as non-root
kubectl exec <db-pod> -- id
# uid=999 (postgres) gid=999

# Verify read-only filesystem
kubectl exec <app-pod> -- touch /test
# Should fail: Read-only file system
```

## Troubleshooting

### Pods can't communicate
1. Check NetworkPolicy: `kubectl get networkpolicy`
2. Verify policy rules: `kubectl describe networkpolicy <name>`
3. Check pod labels match selectors
4. Test with debug container: `kubectl run -it debug --image=nicolaka/netshoot --rm`

### ServiceAccount lacks permissions
1. Check role bindings: `kubectl get rolebindings`
2. Verify RBAC rules: `kubectl describe role <role-name>`
3. Test with: `kubectl auth can-i <verb> <resource> --as=system:serviceaccount:default:<sa-name>`

### Secrets not accessible
1. Verify secret exists: `kubectl get secrets`
2. Check secret name in deployment: `kubectl describe deployment <app>`
3. Ensure serviceaccount has read permission: RBAC rules

## Monitoring & Compliance

### Enable Audit Logging
Monitor security events:
```bash
# View recent audit logs
kubectl logs -n kube-system audit-log | tail -100

# Monitor secret access
kubectl logs -n kube-system audit-log | grep secrets
```

### Regular Security Review
1. **Weekly**: Review audit logs for suspicious activity
2. **Monthly**: Run vulnerability scans on container images
3. **Quarterly**: Review RBAC roles and permissions
4. **Annually**: Full security assessment

## References

- [Kubernetes Security Best Practices](https://kubernetes.io/docs/concepts/security/)
- [NetworkPolicy Documentation](https://kubernetes.io/docs/concepts/services-networking/network-policies/)
- [RBAC Authorization](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)
- [Pod Security Standards](https://kubernetes.io/docs/concepts/security/pod-security-standards/)
- [Container Security Guide](https://kubernetes.io/docs/concepts/security/container-environment/)
