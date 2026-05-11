import http from 'k6/http';
import { check, sleep } from 'k6';
import { Rate, Trend } from 'k6/metrics';

// Custom metrics
const errorRate = new Rate('errors');
const voteLatency = new Trend('vote_latency');
const resultLatency = new Trend('result_latency');

export const options = {
  stages: [
    { duration: '30s', target: 10 },    // Ramp up to 10 users
    { duration: '1m', target: 50 },     // Ramp up to 50 users
    { duration: '2m', target: 50 },     // Stay at 50 users
    { duration: '1m', target: 100 },    // Ramp up to 100 users
    { duration: '2m', target: 100 },    // Stay at 100 users
    { duration: '30s', target: 0 },     // Ramp down
  ],
  thresholds: {
    'http_req_duration': ['p(95)<500', 'p(99)<1000'], // 95% must be below 500ms, 99% below 1000ms
    'errors': ['rate<0.1'],                            // Error rate must be below 10%
  },
  ext: {
    loadimpact: {
      projectID: 3356643,
      name: 'Voting App Load Test'
    }
  }
};

// Vote options
const voteOptions = ['A', 'B'];

export default function () {
  const baseUrl = __ENV.BASE_URL || 'http://localhost:5000';
  
  // Test 1: Get vote page
  let getVoteRes = http.get(`${baseUrl}/`);
  check(getVoteRes, {
    'vote page status is 200': (r) => r.status === 200,
    'vote page response time < 1s': (r) => r.timings.duration < 1000,
  }) || errorRate.add(1);
  voteLatency.add(getVoteRes.timings.duration);
  sleep(1);

  // Test 2: Submit a vote
  const vote = voteOptions[Math.floor(Math.random() * voteOptions.length)];
  let postVoteRes = http.post(
    `${baseUrl}/`,
    { vote: vote },
    { headers: { 'Content-Type': 'application/x-www-form-urlencoded' } }
  );
  check(postVoteRes, {
    'vote submission status is 200 or 303': (r) => r.status === 200 || r.status === 303,
    'vote submission response time < 1s': (r) => r.timings.duration < 1000,
  }) || errorRate.add(1);
  sleep(2);

  // Test 3: Get results page
  const resultUrl = __ENV.RESULT_URL || 'http://localhost:5001';
  let getResultRes = http.get(`${resultUrl}/`);
  check(getResultRes, {
    'result page status is 200': (r) => r.status === 200,
    'result page response time < 1s': (r) => r.timings.duration < 1000,
  }) || errorRate.add(1);
  resultLatency.add(getResultRes.timings.duration);
  sleep(2);
}

export function handleSummary(data) {
  return {
    'stdout': textSummary(data, { indent: ' ', enableColors: true }),
    'summary.json': JSON.stringify(data),
  };
}

// Helper function for text summary
function textSummary(data, options) {
  const { indent = '', enableColors = false } = options;
  let summary = '\n\nLoad Test Summary\n';
  summary += '==================\n\n';
  
  if (data.metrics) {
    summary += 'Metrics:\n';
    for (const [name, values] of Object.entries(data.metrics)) {
      if (values.values) {
        summary += `${indent}${name}:\n`;
        for (const [key, value] of Object.entries(values.values)) {
          summary += `${indent}  ${key}: ${value}\n`;
        }
      }
    }
  }
  
  return summary;
}
