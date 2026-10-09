# Measurement, not hype
Use a fixed test workload with documented concurrency, region, hardware, TLS, cache state and sample size. Collect p50, p95, p99, max, error rate and throughput.

Example with k6:
```bash
k6 run -e BASE_URL=http://localhost:8000 loadtest.js
```
Run against a local test instance you own. Do **not** stress-test services without permission. Compare warm/cold caches and run multiple independent rounds. Record both backend latency and full user-observed request time.
