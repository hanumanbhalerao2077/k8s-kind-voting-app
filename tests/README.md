# Testing Guide

This directory contains testing scripts and configurations for the voting app.

## Directory Structure

```
tests/
├── e2e/                    # End-to-end tests
│   └── run-e2e-tests.sh   # E2E test script
├── load/                   # Load testing
│   ├── votingapp-load-test.js    # Standard load test
│   ├── spike-test.js              # Spike test
│   ├── soak-test.js               # Soak/endurance test
│   └── run-load-tests.sh          # Load test runner
└── integration/            # Integration tests
    └── run-integration-tests.sh   # Integration test script
```

## Test Types

### 1. End-to-End (E2E) Tests

Tests the complete user workflow from voting to result retrieval.

**File**: `e2e/run-e2e-tests.sh`

**What it tests:**
- Vote service availability
- Result service availability
- Vote submission workflow
- Results display
- Data persistence
- Performance baseline

**Run locally:**
```bash
cd tests/e2e
./run-e2e-tests.sh
```

**Run in CI/CD:**
The CI/CD pipeline automatically runs E2E tests on every commit.

**Expected output:**
```
✓ Vote service is healthy
✓ Result service is healthy
✓ Vote 1 submitted successfully
✓ Results retrieved successfully
✓ Vote page response time: XXXms
✓ Result page response time: XXXms
```

### 2. Load Testing

Tests system behavior under various load conditions using k6.

**Prerequisites:**
```bash
# Install k6
# macOS
brew install k6

# Linux
sudo apt-get install k6

# Windows (chocolatey)
choco install k6
```

#### Standard Load Test
**File**: `load/votingapp-load-test.js`

Simulates realistic user traffic with gradual ramp-up and ramp-down.

**Load profile:**
- 30s: Ramp up to 10 users
- 1m: Ramp up to 50 users
- 2m: Hold at 50 users
- 1m: Ramp up to 100 users
- 2m: Hold at 100 users
- 30s: Ramp down

**Run:**
```bash
k6 run tests/load/votingapp-load-test.js
```

**Thresholds:**
- 95th percentile latency: < 500ms
- 99th percentile latency: < 1000ms
- Error rate: < 10%

#### Spike Test
**File**: `load/spike-test.js`

Tests system behavior with sudden traffic spike.

**Run:**
```bash
k6 run tests/load/spike-test.js
```

#### Soak Test
**File**: `load/soak-test.js`

Tests system stability under sustained load over extended period.

**Duration**: ~17 minutes at 100 concurrent users

**Run:**
```bash
k6 run tests/load/soak-test.js
```

#### Run All Load Tests
```bash
cd tests/load
chmod +x run-load-tests.sh
./run-load-tests.sh
```

**Output:**
Results are saved as JSON files in `load-test-results/` directory.

**Analyze results:**
```bash
# Pretty print results
jq . load-test-results/load-test-results.json

# Extract specific metrics
jq '.metrics.http_req_duration.values' load-test-results/load-test-results.json
jq '.metrics.errors.values' load-test-results/load-test-results.json
```

### 3. Integration Tests

Tests connectivity and functionality of dependent services (database, cache).

**File**: `integration/run-integration-tests.sh`

**Prerequisites:**
```bash
# For PostgreSQL tests
apt-get install postgresql-client

# For Redis tests
apt-get install redis-tools
```

**What it tests:**
- PostgreSQL connectivity
- Redis connectivity
- Database schema integrity
- Redis data structures

**Run:**
```bash
./tests/integration/run-integration-tests.sh
```

## CI/CD Integration

The GitHub Actions workflows run tests automatically:

1. **E2E Tests**: Run on every push to `main`/`develop`
2. **Load Tests**: Run on-demand via Actions tab
3. **Integration Tests**: Run before deployment

### View test results in GitHub

1. Go to repository
2. Click "Actions" tab
3. Select workflow run
4. View "Testing" job

### Generate test reports

```bash
# Generate coverage reports
npm test -- --coverage

# Generate performance report
jq . load-test-results/load-test-results.json > performance-report.json
```

## Performance Benchmarks

Expected baseline performance (from your Kind cluster):

| Metric | Vote Service | Result Service |
|--------|-------------|-----------------|
| Response Time (p50) | < 100ms | < 100ms |
| Response Time (p95) | < 300ms | < 300ms |
| Response Time (p99) | < 500ms | < 500ms |
| Error Rate | < 0.1% | < 0.1% |
| Throughput | > 100 req/s | > 100 req/s |

## Stress Testing

Run stress tests to find breaking points:

```bash
k6 run \
  --stage '5m:at(200)' \
  --stage '5m:at(500)' \
  --stage '5m:at(1000)' \
  --stage '5m:at(0)' \
  tests/load/votingapp-load-test.js
```

## Troubleshooting

### E2E tests fail with connection error

Check if services are running:
```bash
# Check vote service
curl http://localhost:5000/

# Check result service
curl http://localhost:5001/

# Forward ports if needed
kubectl port-forward svc/vote 5000:80
kubectl port-forward svc/result 5001:80
```

### k6 not found

```bash
# Install k6
# See instructions at https://k6.io/docs/getting-started/installation/

# Or use Docker
docker run -i grafana/k6 run - < tests/load/votingapp-load-test.js
```

### Load tests show high error rate

1. Check Kubernetes pod health
2. Verify resource limits aren't being hit
3. Check network policies don't block traffic
4. Monitor cluster with `kubectl top nodes` and `kubectl top pods`

## Performance Optimization Tips

Based on test results, optimize:

1. **High latency**: Check database queries, add caching
2. **High error rate**: Check pod logs, increase resource limits
3. **Low throughput**: Add replicas via HPA, optimize code
4. **Memory leaks**: Check memory growth in longer tests

## Continuous Performance Testing

Set up automated performance testing:

1. **Weekly baseline runs**: Schedule load tests to track trends
2. **Before releases**: Always run full test suite
3. **Production monitoring**: Use Prometheus/Grafana metrics
4. **Alerting**: Set up alerts for performance degradation

## References

- [k6 Documentation](https://k6.io/docs/)
- [Testing Best Practices](https://k6.io/docs/testing-guides/)
- [Load Testing Guide](https://k6.io/docs/testing-guides/load-testing-best-practices/)
