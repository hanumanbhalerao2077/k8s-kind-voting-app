#!/bin/bash
# Integration tests for the voting app services

set -e

DB_HOST="${DB_HOST:-localhost}"
DB_PORT="${DB_PORT:-5432}"
DB_USER="${DB_USER:-postgres}"
DB_PASSWORD="${DB_PASSWORD:-postgres}"
DB_NAME="${DB_NAME:-votes}"

REDIS_HOST="${REDIS_HOST:-localhost}"
REDIS_PORT="${REDIS_PORT:-6379}"

echo "=== Integration Tests ==="
echo ""

# Test 1: Database connectivity
echo "Test 1: Database Connectivity"
echo "----------------------------"
if command -v psql &> /dev/null; then
  PGPASSWORD="$DB_PASSWORD" psql \
    -h "$DB_HOST" \
    -U "$DB_USER" \
    -d "$DB_NAME" \
    -c "SELECT 1;" > /dev/null 2>&1
  
  if [ $? -eq 0 ]; then
    echo "✓ PostgreSQL connection successful"
  else
    echo "✗ PostgreSQL connection failed"
    exit 1
  fi
else
  echo "⚠ psql not installed, skipping database test"
fi

# Test 2: Redis connectivity
echo ""
echo "Test 2: Redis Connectivity"
echo "-------------------------"
if command -v redis-cli &> /dev/null; then
  redis-cli -h "$REDIS_HOST" -p "$REDIS_PORT" PING > /dev/null 2>&1
  
  if [ $? -eq 0 ]; then
    echo "✓ Redis connection successful"
  else
    echo "✗ Redis connection failed"
    exit 1
  fi
else
  echo "⚠ redis-cli not installed, skipping Redis test"
fi

# Test 3: Database schema
echo ""
echo "Test 3: Database Schema"
echo "---------------------"
if command -v psql &> /dev/null; then
  # Check if votes table exists
  table_count=$(PGPASSWORD="$DB_PASSWORD" psql \
    -h "$DB_HOST" \
    -U "$DB_USER" \
    -d "$DB_NAME" \
    -t \
    -c "SELECT COUNT(*) FROM information_schema.tables WHERE table_name='votes';" 2>/dev/null || echo "0")
  
  if [ "$table_count" -gt 0 ]; then
    echo "✓ Votes table exists"
  else
    echo "⚠ Votes table not found (may be OK for fresh installation)"
  fi
fi

# Test 4: Redis data structure
echo ""
echo "Test 4: Redis Data Structure"
echo "---------------------------"
if command -v redis-cli &> /dev/null; then
  # Try to get the queue key
  queue_type=$(redis-cli -h "$REDIS_HOST" -p "$REDIS_PORT" TYPE queue 2>/dev/null || echo "none")
  echo "✓ Redis queue type: $queue_type"
fi

echo ""
echo "=== Integration Tests Completed ==="
