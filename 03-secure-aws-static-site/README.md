# Level 3 — Private S3 + CloudFront + Terraform
Terraform creates a private S3 bucket, blocks public access, and allows read access only from a CloudFront Origin Access Control distribution. CloudFront uses its default HTTPS domain.

## Prerequisites
AWS credentials through a named profile or a short-lived role, Terraform >=1.6, an AWS account with billing enabled.

## Deploy
```bash
terraform init
terraform fmt -check
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
aws s3 cp site/index.html "s3://$(terraform output -raw bucket_name)/index.html" --content-type text/html
terraform output cloudfront_domain
```
CloudFront distribution rollout and caching may take time. Access the distribution via HTTPS. Use invalidations when modifying an already cached asset.

## Important
AWS resources **cost money**; review prices before apply. This exercise creates a globally named S3 bucket. Use unique `name_suffix`; do not commit state files, credentials, plans or secrets. To clean up: empty the bucket, then `terraform destroy`.

For a production system: custom domain and ACM certificate in us-east-1, WAF, budgets/alerts, access logging, OAC policy review, CI via OIDC and version pinning.
