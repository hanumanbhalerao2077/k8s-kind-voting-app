#!/bin/bash
# Load testing script using k6

set -e

# Configuration
VOTE_URL="${VOTE_URL:-http://localhost:5000}"
RESULT_URL="${RESULT_URL:-http://localhost:5001}"
TEST_DURATION="${TEST_DURATION:-5m}"
OUTPUT_DIR="./load-test-results"

# Create output directory
mkdir -p "$OUTPUT_DIR"

echo "=== K6 Load Testing Suite ==="
echo "Vote URL: $VOTE_URL"
echo "Result URL: $RESULT_URL"
echo ""

# Test 1: Standard load test
echo "Running standard load test..."
k6 run \
  --out json="$OUTPUT_DIR/load-test-results.json" \
  -e BASE_URL="$VOTE_URL" \
  -e RESULT_URL="$RESULT_URL" \
  ./votingapp-load-test.js

# Test 2: Spike test
echo ""
echo "Running spike test..."
k6 run \
  --out json="$OUTPUT_DIR/spike-test-results.json" \
  -e BASE_URL="$VOTE_URL" \
  ./spike-test.js

# Test 3: Soak test
echo ""
echo "Running soak test..."
k6 run \
  --out json="$OUTPUT_DIR/soak-test-results.json" \
  -e BASE_URL="$VOTE_URL" \
  ./soak-test.js

echo ""
echo "=== Load tests completed ==="
echo "Results saved to: $OUTPUT_DIR"
echo ""
echo "Summary:"
echo "--------"

# Parse and display results
if command -v jq &> /dev/null; then
  echo ""
  echo "Standard Load Test:"
  jq '.metrics.http_req_duration.values | {p95, p99, avg}' "$OUTPUT_DIR/load-test-results.json" || true
  
  echo ""
  echo "Error Rate:"
  jq '.metrics.errors.values' "$OUTPUT_DIR/load-test-results.json" || true
fi

echo ""
echo "View detailed results:"
echo "  cat $OUTPUT_DIR/load-test-results.json | jq ."
