import http from 'k6/http';
import { check, sleep } from 'k6';
export const options = {
  vus: 5,
  duration: '30s',
  thresholds: { http_req_failed: ['rate<0.01'], http_req_duration: ['p(95)<250'] }
};
export default function () {
  const base = __ENV.BASE_URL || 'http://localhost:8000';
  const response = http.get(base + '/api/time');
  check(response, { 'HTTP 200': r => r.status === 200 });
  sleep(0.3);
}
