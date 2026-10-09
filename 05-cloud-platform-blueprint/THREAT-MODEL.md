# Threat model (starter)
| Asset | Threat | Control | Validation |
|---|---|---|---|
| Public API | Abuse or floods | CDN/WAF rate rules, request budgets | Load tests + rate-limit tests |
| Credentials | Repository secret leak | OIDC, short-lived roles, secret scanning | Scan git history; IAM review |
| Kubernetes pods | Container breakout | Restricted PSS, seccomp, drop caps | Policy admission tests |
| Private storage | Accidental public read | Public-access block, CloudFront OAC | Attempt anonymous S3 GET |
| Customer data | Data exfiltration | Private networking, narrow IAM | Permission tests and flow logs |
| Availability | Regional/AZ outage | Backups and tested recovery | Recovery game day |
| CI pipeline | Dependency compromise | Lockfiles, scanning, provenance | PR scanning controls |

## Trust boundaries
Internet / edge CDN / VPC ingress / workload / data. Treat every crossing as untrusted until authenticated, authorized and encrypted as appropriate. CDN caching never makes confidential API responses public.
