import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  stages: [
    { duration: '1m', target: 100 },    // Ramp up
    { duration: '5m', target: 100 },    // Soak
    { duration: '10m', target: 100 },   // Extended soak
    { duration: '1m', target: 0 },      // Ramp down
  ],
  thresholds: {
    'http_req_duration': ['p(95)<1000'],
  }
};

export default function () {
  const baseUrl = __ENV.BASE_URL || 'http://localhost:5000';
  
  // Sustained load test
  let res = http.get(`${baseUrl}/`);
  check(res, {
    'soak test - status 200': (r) => r.status === 200,
    'soak test - response time < 1s': (r) => r.timings.duration < 1000,
  });
  sleep(2);
}
