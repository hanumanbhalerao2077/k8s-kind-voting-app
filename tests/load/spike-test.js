import http from 'k6/http';
import { check } from 'k6';
import { Rate } from 'k6/metrics';

const errorRate = new Rate('errors');

export const options = {
  stages: [
    { duration: '10s', target: 5 },     // Quick ramp up
    { duration: '30s', target: 5 },     // Hold load
    { duration: '10s', target: 0 },     // Ramp down
  ],
  thresholds: {
    'http_req_duration': ['p(95)<1000'],
    'errors': ['rate<0.05'],
  }
};

export default function () {
  const baseUrl = __ENV.BASE_URL || 'http://localhost:5000';
  
  // Spike test - sudden traffic increase
  let res = http.get(`${baseUrl}/`);
  check(res, {
    'spike test - status 200': (r) => r.status === 200,
    'spike test - response time < 2s': (r) => r.timings.duration < 2000,
  }) || errorRate.add(1);
}
