# Kubernetes Specifications Enhancements

This directory contains enhanced Kubernetes manifests with production-ready features.

## Files Overview

### Deployments
- **vote-deployment.yaml**: Vote service with probes, resource limits, HPA support
- **result-deployment.yaml**: Result service with enhanced configuration
- **worker-deployment.yaml**: Worker service as background job processor
- **db-deployment.yaml**: PostgreSQL database with persistent storage
- **redis-deployment.yaml**: Redis cache with persistence (RDB)

### Supporting Resources

#### Persistence
- **persistent-volumes.yaml**: PersistentVolumeClaims for databases
  - 10Gi for PostgreSQL
  - 5Gi for Redis

#### Autoscaling
- **hpa.yaml**: HorizontalPodAutoscaler resources
  - Vote: scales 2-5 replicas on CPU/memory
  - Result: scales 2-5 replicas
  - Worker: scales 2-10 replicas for processing jobs

#### Security
- **service-accounts.yaml**: ServiceAccounts for RBAC
- **secrets-config.yaml**: Secrets and ConfigMaps
  - Database credentials
  - Application configuration

#### Resilience
- **pod-disruption-budgets.yaml**: PodDisruptionBudgets
  - Maintains availability during node maintenance
  - Minimum 1 pod always available

### Services
- **vote-service.yaml**: Exposes vote service on port 5000
- **result-service.yaml**: Exposes result service on port 5001
- **db-service.yaml**: Internal database service
- **redis-service.yaml**: Internal Redis service

## Features Added

### Resource Management
- **Requests**: Minimum CPU/memory guaranteed
- **Limits**: Maximum resources allowed
- **QoS**: Guaranteed for critical services

### Health Checks
- **Liveness Probes**: Restart unhealthy pods
  - HTTP for web services
  - Exec for database/cache
- **Readiness Probes**: Route traffic only to ready pods

### Deployment Strategy
- **RollingUpdate**: Zero-downtime updates
- **MaxSurge**: Max 1 extra pod during rollout
- **MaxUnavailable**: Never take down all pods

### Security
- **SecurityContext**: Run as non-root where possible
- **Capabilities**: Drop unnecessary Linux capabilities
- **ReadOnlyFilesystem**: Where applicable
- **ServiceAccounts**: Proper RBAC configuration

### High Availability
- **Multiple Replicas**: Minimum 2 for web services
- **Pod Anti-Affinity**: Spread pods across nodes
- **Pod Disruption Budgets**: Prevent simultaneous pod removal
- **HorizontalPodAutoscaler**: Auto-scale based on metrics

## Deployment Order

```bash
# 1. Create namespace (if not default)
kubectl create namespace voting-app

# 2. Create secrets and config first
kubectl apply -f secrets-config.yaml

# 3. Create service accounts
kubectl apply -f service-accounts.yaml

# 4. Create persistent volumes
kubectl apply -f persistent-volumes.yaml

# 5. Deploy databases first
kubectl apply -f db-deployment.yaml
kubectl apply -f redis-deployment.yaml

# 6. Deploy database services
kubectl apply -f db-service.yaml
kubectl apply -f redis-service.yaml

# 7. Deploy application services
kubectl apply -f vote-deployment.yaml
kubectl apply -f result-deployment.yaml
kubectl apply -f worker-deployment.yaml

# 8. Create services
kubectl apply -f vote-service.yaml
kubectl apply -f result-service.yaml

# 9. Create HPA and PDB
kubectl apply -f hpa.yaml
kubectl apply -f pod-disruption-budgets.yaml
```

Or apply all at once:
```bash
kubectl apply -f .
```

## Verification

```bash
# Check deployments
kubectl get deployments

# Check pods
kubectl get pods

# Check HPA status
kubectl get hpa

# Check PVC status
kubectl get pvc

# View pod logs
kubectl logs -f deployment/vote

# Describe pod for events
kubectl describe pod <pod-name>
```

## Configuration Customization

### Database Password
Edit `secrets-config.yaml` and update the base64-encoded password:
```bash
echo -n "new-password" | base64
```

### Resource Limits
Adjust CPU/memory in deployment files based on:
- Expected traffic
- Available cluster resources
- Application requirements

### HPA Settings
Modify `hpa.yaml` for different scaling policies:
- `minReplicas`: Minimum pods to maintain
- `maxReplicas`: Maximum pods allowed
- `averageUtilization`: CPU/memory threshold

### Storage
Change storage size in `persistent-volumes.yaml` as needed

## Monitoring

### Metrics Required
Install metrics-server for HPA:
```bash
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
```

### Check HPA Activity
```bash
kubectl get hpa -w
```

## Production Considerations

1. **Replace emptyDir with proper storage**: Use cloud storage (EBS, GCP Persistent Disk) for production
2. **Update images to your registry**: Change `dockersamples/*` to your image registry
3. **Configure resource limits**: Adjust based on real metrics from testing
4. **Enable persistent backups**: Add backup policies for databases
5. **Set up monitoring**: Deploy Prometheus/Grafana for metrics
6. **Configure logging**: Add ELK or Loki for centralized logs
7. **Implement NetworkPolicies**: Restrict traffic between pods
8. **Use secrets management**: Use external secret operators for credentials
