# Level 1 — Fast Secure Web
A tiny responsive static site served through a locked-down Nginx configuration.

## Run
```bash
docker build -t fast-secure-web .
docker run --rm -p 8080:8080 fast-secure-web
curl -I http://localhost:8080
```
Open http://localhost:8080. The HTML/CSS have no external dependencies.

## Verify
- Inspect CSP, X-Content-Type-Options and other headers with `curl -I`.
- Compare `curl -w '%{time_total}' -o /dev/null -s http://localhost:8080/` over multiple requests.
- Docker container runs without root. Avoid framing one local latency sample as an Internet benchmark.

## Security and performance
Default-deny CSP, no external JS/fonts, static asset caching and gzip. **Production**: terminate TLS at a trusted load balancer/CDN, configure a real domain and HSTS there, evaluate CSP in actual browsers, and run a dependency/image scanner.
