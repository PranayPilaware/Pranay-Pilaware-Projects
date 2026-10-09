# Cloud Security & Low-Latency Engineering Portfolio

Five progressive, hands-on projects covering secure HTTP delivery, container hardening, AWS IaC, Kubernetes policy, and production-style edge architecture.

| Level | Project | Core skills |
|---|---|---|
| 1 | [Fast Secure Web](01-fast-secure-web/) | Nginx, caching, security headers, static performance |
| 2 | [Hardened API](02-hardened-api/) | Python, Docker, health checks, non-root workloads, CI |
| 3 | [Secure AWS Static Site](03-secure-aws-static-site/) | Terraform, private S3, CloudFront, TLS, cost controls |
| 4 | [Kubernetes Secure API](04-k8s-secure-api/) | Deployments, probes, resource limits, network policy |
| 5 | [Cloud Platform Blueprint](05-cloud-platform-blueprint/) | Defense in depth, WAF, OIDC, caching, SLOs, DR |

## Start here

Each folder contains its own README with prerequisites, commands, validation criteria and security trade-offs. These are **reproducible portfolio labs**, not a claim that cloud resources have already been deployed or performance targets measured. Do not put AWS credentials, personal data or secrets in Git. Use your own AWS account and monitor billing.

### What to demonstrate to recruiters

1. Run each lab yourself; attach screenshots and benchmark output.
2. Explain every security decision and its limitations.
3. Show CI checks passing and record measured p50/p95/p99 response latency under a defined workload.
4. Keep a changelog of fixes and trade-offs.

**Owner:** [Pranay Pilaware](https://github.com/PranayPilaware)
