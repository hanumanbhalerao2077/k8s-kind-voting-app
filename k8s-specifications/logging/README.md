# Centralized Logging Setup

This directory contains configurations for centralized logging using two approaches:

## Option 1: ELK Stack (Elasticsearch, Logstash, Kibana)

Full-featured logging solution with powerful search and analysis capabilities.

### Files
- **elk.yaml**: Elasticsearch, Kibana, and Filebeat deployment

### Quick Start

```bash
# Deploy ELK stack
kubectl apply -f elk.yaml

# Verify deployment
kubectl get deployments -n logging
kubectl get statefulsets -n logging

# Access Kibana
kubectl port-forward -n logging svc/kibana 5601:5601
# Open: http://localhost:5601
```

### Architecture

```
Application Logs (stdout/stderr)
    ↓
Docker Daemon
    ↓
Filebeat (DaemonSet)
    ↓
Elasticsearch (StatefulSet)
    ↓
Kibana (Frontend)
```

### Features

- **Elasticsearch**: Distributed search and analytics engine
- **Kibana**: Visualization and exploration platform
- **Filebeat**: Lightweight log shipper

### Resource Requirements

- Elasticsearch: 512Mi-1Gi RAM, 100m-500m CPU
- Kibana: 256Mi-512Mi RAM, 100m-200m CPU
- Filebeat: 64Mi per node, 50m-100m CPU
- Storage: 10Gi for Elasticsearch

### Configuration

#### Add Custom Index Pattern in Kibana

1. Kibana → Management → Stack Management → Index Patterns
2. Click "Create index pattern"
3. Index name: `filebeat-*`
4. Time field: `@timestamp`
5. Click "Create"

#### Create Dashboards

1. Kibana → Analytics → Dashboard
2. Click "Create dashboard"
3. Add visualizations based on your metrics

### Queries

#### Find logs from a pod
```
kubernetes.pod.name: "vote-*"
```

#### Find error logs
```
log: "ERROR" or level: "error"
```

#### Show logs from specific namespace
```
kubernetes.namespace: "default"
```

## Option 2: Loki + Promtail (Kubernetes-Native)

Lightweight, cloud-native logging solution optimized for Kubernetes.

### Files
- **loki.yaml**: Loki and Promtail deployment

### Quick Start

```bash
# Deploy Loki + Promtail
kubectl apply -f loki.yaml

# Verify deployment
kubectl get statefulsets -n logging
kubectl get daemonsets -n logging

# Access Loki via Grafana
kubectl port-forward -n monitoring svc/grafana 3000:3000
```

### Architecture

```
Pod Logs (stdout/stderr)
    ↓
Promtail (DaemonSet)
    ↓
Loki (StatefulSet)
    ↓
Grafana (Visualization)
```

### Features

- **Loki**: Log aggregation system inspired by Prometheus
- **Promtail**: Log shipper for Kubernetes
- **Grafana Integration**: Queries logs within Grafana

### Resource Requirements (Much Lighter than ELK)

- Loki: 64Mi-256Mi RAM, 50m-200m CPU
- Promtail: 32Mi-64Mi RAM, 50m-100m CPU per node
- Storage: 5Gi for Loki

### Advantages Over ELK

- Lower resource consumption
- Label-based querying (like Prometheus)
- Integrates with Prometheus/Grafana stack
- Easier to scale horizontally
- Better for containerized environments

### Add Loki as Data Source in Grafana

1. Grafana → Configuration → Data Sources
2. Click "Add data source" → Select "Loki"
3. Set URL to: `http://loki:3100`
4. Click "Save & Test"

### Query Loki (LogQL)

#### Show all logs from vote service
```
{app="vote"}
```

#### Show error logs
```
{namespace="default"} |= "error"
```

#### Count logs by pod
```
count_over_time({namespace="default"}[5m])
```

#### Show logs with duration stats
```
{app="vote"} | json | line_format "{{.duration}}ms"
```

## Comparison

| Feature | ELK | Loki |
|---------|-----|------|
| Memory Usage | 1GB+ | 256MB |
| CPU Usage | 500m+ | 200m |
| Storage | 10GB+ | 5GB |
| Query Power | Very Powerful | Lightweight |
| Setup Complexity | Complex | Simple |
| Kubernetes Optimized | No | Yes |
| Log Analysis | Excellent | Basic |
| Cost | High | Low |

## Which to Choose?

### Use ELK if you need:
- Complex log analysis and correlations
- Advanced visualizations
- Full-text search
- Large-scale deployments
- Non-Kubernetes logs

### Use Loki if you need:
- Lightweight setup
- Quick log searching
- Kubernetes-native monitoring
- Integration with Prometheus
- Lower resource consumption

## Deployment Order

### For ELK Stack:
```bash
# 1. Deploy Elasticsearch first
kubectl apply -f elk.yaml

# 2. Wait for Elasticsearch to be ready (takes time)
kubectl wait --for=condition=ready pod -l app=elasticsearch -n logging --timeout=300s

# 3. Verify and access Kibana
kubectl port-forward -n logging svc/kibana 5601:5601
```

### For Loki:
```bash
# 1. Deploy Loki and Promtail
kubectl apply -f loki.yaml

# 2. Verify deployment
kubectl get pods -n logging

# 3. Access via Grafana
kubectl port-forward -n monitoring svc/grafana 3000:3000
```

## Troubleshooting

### Elasticsearch not starting
```bash
# Check logs
kubectl logs -n logging -l app=elasticsearch

# Common issues:
# - Not enough memory
# - Disk space full
# - Security configuration error
```

### No logs appearing
```bash
# Check Filebeat/Promtail is running
kubectl get daemonsets -n logging

# Check pod logs
kubectl logs -n logging -l app=filebeat
kubectl logs -n logging -l app=promtail

# Verify connection to Elasticsearch/Loki
kubectl exec -it <filebeat/promtail-pod> -n logging -- curl http://elasticsearch:9200
kubectl exec -it <promtail-pod> -n logging -- curl http://loki:3100/loki/api/v1/status/ready
```

### High disk usage
```bash
# Check Elasticsearch index sizes
curl http://localhost:9200/_cat/indices?v

# Delete old indices
curl -X DELETE http://localhost:9200/filebeat-2024.01.01
```

## Monitoring the Logging Stack

### Monitor Elasticsearch Health
```bash
# Port forward
kubectl port-forward -n logging svc/elasticsearch 9200:9200

# Check cluster health
curl http://localhost:9200/_cluster/health?pretty

# Monitor indices
curl http://localhost:9200/_cat/indices?v

# Monitor nodes
curl http://localhost:9200/_cat/nodes?v
```

### Monitor Loki
```bash
# Check Loki metrics
curl http://localhost:3100/metrics
```

## Backup & Restore

### Backup Elasticsearch
```bash
# Create snapshot repository
curl -X PUT "localhost:9200/_snapshot/my_backup" -H 'Content-Type: application/json' \
  -d'{ "type": "fs", "settings": { "location": "/backup" } }'

# Take snapshot
curl -X PUT "localhost:9200/_snapshot/my_backup/snapshot_1"
```

### Backup Loki
```bash
# Backup boltdb files
kubectl exec -it -n logging <loki-pod> -- tar -czf /backup/loki-backup.tar.gz /loki/boltdb-shipper-active
```

## Performance Tuning

### For ELK Stack
```yaml
# Elasticsearch JVM heap
ES_JAVA_OPTS: "-Xms1g -Xmx1g"  # Adjust for available memory

# Elasticsearch refresh interval
curl -X PUT "localhost:9200/filebeat-*/_settings" \
  -H 'Content-Type: application/json' \
  -d'{"index" : {"refresh_interval" : "30s"}}'
```

### For Loki
```yaml
# Adjust chunk retention
chunk_idle_period: 3m
chunk_retain_period: 1m
max_chunk_age: 1h
```

## References

- [Elasticsearch Documentation](https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html)
- [Kibana Documentation](https://www.elastic.co/guide/en/kibana/current/index.html)
- [Loki Documentation](https://grafana.com/docs/loki/latest/)
- [Promtail Documentation](https://grafana.com/docs/loki/latest/send-data/promtail/)
