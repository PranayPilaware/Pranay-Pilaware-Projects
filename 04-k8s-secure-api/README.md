# Level 4 — Kubernetes Secure API
A Kubernetes deployment of the Level 2 Python API with a restrictive security context, health probes, resource limits, and default-deny ingress plus explicit allowance from a labeled ingress namespace.

## Prerequisites
Local cluster (kind or minikube) with a CNI implementing NetworkPolicy, Docker and kubectl.

## Run
```bash
docker build -t secure-api:lab ../02-hardened-api
kind load docker-image secure-api:lab
kubectl apply -f namespace.yaml
kubectl apply -f deployment.yaml
kubectl apply -f networkpolicy.yaml
kubectl -n portfolio get pods
kubectl -n portfolio port-forward svc/secure-api 8000:8000
curl http://localhost:8000/healthz
```
NetworkPolicy requires a compatible CNI. Some local clusters do not enforce policies; test actual network isolation, don't infer it from YAML alone. For a public production workload implement ingress/controller TLS and correct namespace labels; do not simply expose this lab to the Internet.
