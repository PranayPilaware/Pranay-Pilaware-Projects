# Level 5 — Secure, Low-Latency Cloud Platform Blueprint
An end-to-end architectural **blueprint** integrating the previous labs. This is intentionally a design-and-validation exercise, **not deployed production IaC**.

## Request path
```text
Client -> DNS -> CDN + WAF -> TLS ingress -> Kubernetes API -> managed datastore
                   |                    |               |
                edge cache            policies      private subnet
```

## Build stages
1. Deploy Level 3 private-origin website to CloudFront; collect cache hit and miss response timings.
2. Deploy Level 4 API to managed Kubernetes only after implementing cluster networking, Ingress TLS and outbound restrictions.
3. Use OIDC federated CI instead of long-lived AWS access keys.
4. Add a WAF managed ruleset, rate limiting, structured request IDs and dashboards.
5. Define SLOs, load test with k6, and practice rollbacks.

## Security requirements
- Identity: OIDC trust restricted by repository, branch and role; least-privilege IAM policies.
- Data: private subnets, encryption in transit and at rest, protected secrets.
- Workload: non-root containers, image scans, pinned digests, Kubernetes network policies.
- Edge: HTTPS and HSTS (on fully configured TLS domain), WAF, bot/rate-limiting controls.
- Reliability: health checks, multi-AZ as budget allows, resource quotas and rollback plans.
- Supply chain: CI permissions minimum, dependency alerts, artifacts and provenance.

## SLO experiment
Target example: 99.9% success and API p95 under 250 ms **for a defined region/test load**. These are design goals, not actual results. Measure and record baselines before deciding whether caching, indexing, compute or networking is the bottleneck.

## Cost and teardown
Never provision a production-scale Kubernetes cluster for this lab without checking costs. Prefer local Kubernetes first; destroy cloud resources promptly.

See [threat model](THREAT-MODEL.md) and [performance plan](PERFORMANCE.md).
