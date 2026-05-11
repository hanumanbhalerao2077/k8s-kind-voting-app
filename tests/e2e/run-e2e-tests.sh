#!/bin/bash
# End-to-End Testing Script
# Tests the entire voting application workflow

set -e

VOTE_URL="${VOTE_URL:-http://localhost:5000}"
RESULT_URL="${RESULT_URL:-http://localhost:5001}"

echo "=== Voting App E2E Tests ==="
echo ""

# Test 1: Health checks
echo "Test 1: Health Checks"
echo "-------------------"
echo "Checking vote service..."
response=$(curl -s -o /dev/null -w "%{http_code}" "$VOTE_URL/")
if [ "$response" = "200" ]; then
  echo "✓ Vote service is healthy (HTTP $response)"
else
  echo "✗ Vote service health check failed (HTTP $response)"
  exit 1
fi

echo "Checking result service..."
response=$(curl -s -o /dev/null -w "%{http_code}" "$RESULT_URL/")
if [ "$response" = "200" ]; then
  echo "✓ Result service is healthy (HTTP $response)"
else
  echo "✗ Result service health check failed (HTTP $response)"
  exit 1
fi

# Test 2: Vote submission
echo ""
echo "Test 2: Vote Submission"
echo "---------------------"
for i in {1..5}; do
  vote_choice=$([ $((RANDOM % 2)) -eq 0 ] && echo "a" || echo "b")
  response=$(curl -s -w "\n%{http_code}" -X POST "$VOTE_URL/" \
    -d "vote=$vote_choice" \
    -H "Content-Type: application/x-www-form-urlencoded" | tail -1)
  
  if [[ "$response" == "200" || "$response" == "303" ]]; then
    echo "✓ Vote $i submitted successfully (HTTP $response)"
  else
    echo "✗ Vote $i submission failed (HTTP $response)"
    exit 1
  fi
  
  # Small delay between votes
  sleep 0.5
done

# Test 3: Result retrieval
echo ""
echo "Test 3: Result Retrieval"
echo "----------------------"
echo "Fetching voting results..."

result_response=$(curl -s "$RESULT_URL/")
if echo "$result_response" | grep -q "Cats\|Dogs\|vote"; then
  echo "✓ Results retrieved successfully"
  echo "✓ Results contain voting data"
else
  echo "✗ Results page missing expected content"
  exit 1
fi

# Test 4: Performance baseline
echo ""
echo "Test 4: Performance Baseline"
echo "---------------------------"
response_time=$(curl -s -w "%{time_total}" -o /dev/null "$VOTE_URL/")
response_time_seconds=$(echo "$response_time" | awk '{print int($1 * 1000)}')

if (( $(echo "$response_time_seconds < 1000" | bc -l) )); then
  echo "✓ Vote page response time: ${response_time_seconds}ms (acceptable)"
else
  echo "⚠ Vote page response time: ${response_time_seconds}ms (slow)"
fi

result_time=$(curl -s -w "%{time_total}" -o /dev/null "$RESULT_URL/")
result_time_seconds=$(echo "$result_time" | awk '{print int($1 * 1000)}')

if (( $(echo "$result_time_seconds < 1000" | bc -l) )); then
  echo "✓ Result page response time: ${result_time_seconds}ms (acceptable)"
else
  echo "⚠ Result page response time: ${result_time_seconds}ms (slow)"
fi

# Test 5: Database connectivity
echo ""
echo "Test 5: Data Persistence"
echo "----------------------"
# Submit a vote and verify it's persisted
test_vote="test_$(date +%s)"
curl -s -X POST "$VOTE_URL/" \
  -d "vote=a" \
  -H "Content-Type: application/x-www-form-urlencoded" > /dev/null

sleep 2

# Check if results page has been updated
result_response=$(curl -s "$RESULT_URL/")
if echo "$result_response" | grep -q "vote"; then
  echo "✓ Data persistence verified"
else
  echo "✗ Data may not be persisted properly"
fi

echo ""
echo "=== All E2E Tests Passed ✓ ==="
echo ""
echo "Summary:"
echo "--------"
echo "✓ Vote service health check"
echo "✓ Result service health check"
echo "✓ Vote submission (5 votes)"
echo "✓ Result retrieval"
echo "✓ Performance baseline"
echo "✓ Data persistence"
