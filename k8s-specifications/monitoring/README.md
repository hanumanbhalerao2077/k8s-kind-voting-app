# Prometheus & Grafana Monitoring Setup

This directory contains Kubernetes manifests for deploying Prometheus and Grafana for monitoring the voting app.

## Quick Start

### 1. Deploy Monitoring Stack

```bash
# Create monitoring namespace and deploy Prometheus & Grafana
kubectl apply -f prometheus.yaml
kubectl apply -f grafana.yaml

# Verify deployments
kubectl get deployments -n monitoring
kubectl get pods -n monitoring
```

### 2. Access Prometheus

```bash
# Port forward to Prometheus
kubectl port-forward -n monitoring svc/prometheus 9090:9090

# Open in browser: http://localhost:9090
```

### 3. Access Grafana

```bash
# Port forward to Grafana
kubectl port-forward -n monitoring svc/grafana 3000:3000

# Open in browser: http://localhost:3000
# Default credentials: admin / admin (change after login!)
```

### 4. Add Prometheus Data Source to Grafana

1. In Grafana, go to Configuration → Data Sources
2. Click "Add data source" → Select "Prometheus"
3. Set URL to: `http://prometheus:9090`
4. Click "Save & Test"

### 5. Import Dashboards

#### Option A: Import from Grafana Cloud

1. Go to Grafana Home → Dashboards → New → Import
2. Search for:
   - **Kubernetes Cluster (ID: 7249)**
   - **Node Exporter (ID: 1860)**
   - **Docker and Host Monitoring (ID: 10619)**
3. Select Prometheus as data source
4. Click Import

#### Option B: Use Provided Dashboard

A basic dashboard is already provisioned in `grafana.yaml`.

## Architecture

### Components

- **Prometheus**: Metrics collection and storage
  - Scrapes metrics from pods and Kubernetes API
  - Evaluates alert rules
  - Stores time-series data for 30 days

- **Grafana**: Visualization and dashboarding
  - Queries Prometheus for metrics
  - Provides dashboards and alerts
  - User-friendly interface

- **kube-state-metrics**: Kubernetes resource metrics
  - Exposes Kubernetes object metrics (deployments, pods, etc.)
  - Collected by Prometheus

### Metrics Collected

#### Application Metrics (via Prometheus annotations)
```yaml
annotations:
  prometheus.io/scrape: "true"
  prometheus.io/port: "80"
  prometheus.io/path: "/metrics"
```

#### Kubernetes Metrics
- Pod CPU, memory, network
- Deployment replicas and status
- Node resource utilization
- Container restarts

#### Prometheus Metrics
- Scrape duration and failures
- TSDB operations
- Target health

### Data Flow

```
Application Pods (metrics)
    ↓
Prometheus (scrape & store)
    ↓
Grafana (query & visualize)
    ↓
Dashboard
```

## Configuration

### Prometheus Configuration

Edit `prometheus.yaml` ConfigMap to:

1. **Add new scrape targets**:
```yaml
scrape_configs:
  - job_name: 'my-service'
    static_configs:
    - targets: ['my-service:8080']
```

2. **Add alert rules**:
```yaml
rule_files:
  - '/etc/prometheus/rules/*.yml'
```

3. **Change retention**:
```yaml
--storage.tsdb.retention.time=30d  # Change to desired retention
```

### Grafana Configuration

Edit `grafana.yaml` to:

1. **Change admin password**:
```bash
kubectl patch secret grafana-secret -n monitoring \
  -p '{"data":{"admin-password":"'$(echo -n 'newpassword' | base64)'"}}'
```

2. **Add custom dashboards**:
Edit the `grafana-dashboards` ConfigMap

3. **Configure alerts**:
In Grafana: Alerting → Alert rules

## Common Queries

### CPU Usage
```promql
100 - (avg by (instance) (irate(node_cpu_seconds_total{mode="idle"}[5m])) * 100)
```

### Memory Usage
```promql
(1 - (node_memory_MemAvailable_bytes / node_memory_MemTotal_bytes)) * 100
```

### Pod Restart Count
```promql
increase(kube_pod_container_status_restarts_total[1h])
```

### Request Rate
```promql
rate(http_requests_total[1m])
```

### Error Rate
```promql
rate(http_requests_total{status=~"5.."}[1m])
```

## Alerting

### Configure Alert Notification Channels

1. In Grafana: Alerting → Notification channels
2. Add channel (Slack, PagerDuty, email, etc.)
3. Set as default

### Example Alert Rules in Prometheus

```yaml
- alert: HighCPUUsage
  expr: node_cpu_usage > 0.8
  for: 5m
  labels:
    severity: warning
  annotations:
    summary: "High CPU on {{ $labels.instance }}"
```

## Troubleshooting

### Prometheus not scraping targets

1. Check targets in Prometheus UI: http://localhost:9090/targets
2. Look for "Down" targets and check error message
3. Verify pod has correct annotations:
```bash
kubectl get pod <name> -o yaml | grep prometheus
```

### Grafana datasource connection fails

```bash
# Check if Prometheus is reachable from Grafana
kubectl exec -it -n monitoring <grafana-pod> -- curl http://prometheus:9090/-/healthy
```

### Metrics not appearing in dashboards

1. Verify metrics are being scraped: Prometheus → Targets
2. Check query syntax in dashboard
3. Verify datasource configuration

### High memory usage

1. Reduce metrics retention: `--storage.tsdb.retention.time=7d`
2. Increase storage limit in deployment
3. Delete old metrics: `promtool tsdb delete`

## Scaling Prometheus

For large clusters, consider:

1. **Thanos**: Multi-cluster and long-term storage
2. **Cortex**: Horizontally scalable Prometheus
3. **Prometheus Federation**: Multiple Prometheus instances
4. **Remote Storage**: Store metrics externally (S3, GCS)

## Performance Tuning

### Reduce Scrape Load

```yaml
global:
  scrape_interval: 30s  # Increase from 15s
  evaluation_interval: 30s
```

### Adjust Query Timeout

```yaml
global:
  query_timeout: 2m
```

### Optimize Storage

```yaml
--storage.tsdb.max-block-duration=2h  # Smaller blocks = faster queries
--storage.tsdb.min-block-duration=2h
```

## Backup & Recovery

### Backup Prometheus Data

```bash
# Take a snapshot
curl -X POST http://localhost:9090/api/v1/admin/tsdb/snapshot

# Backup directory
tar -czf prometheus-backup.tar.gz /var/lib/prometheus
```

### Restore Prometheus Data

```bash
# Restore from backup
tar -xzf prometheus-backup.tar.gz -C /var/lib/prometheus
```

## References

- [Prometheus Documentation](https://prometheus.io/docs/)
- [Grafana Documentation](https://grafana.com/docs/)
- [Kubernetes Monitoring Guide](https://kubernetes.io/docs/tasks/debug-application-cluster/resource-metrics-pipeline/)
- [Prometheus Operator](https://github.com/prometheus-operator/prometheus-operator)
