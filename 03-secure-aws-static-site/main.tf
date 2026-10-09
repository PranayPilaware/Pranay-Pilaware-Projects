variable "region" { type = string, default = "us-east-1" }
variable "name_suffix" { type = string }
locals { bucket_name = "pranay-secure-static-${var.name_suffix}" }
resource "aws_s3_bucket" "site" { bucket = local.bucket_name }
resource "aws_s3_bucket_public_access_block" "site" {
  bucket = aws_s3_bucket.site.id
  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}
resource "aws_s3_bucket_server_side_encryption_configuration" "site" {
  bucket = aws_s3_bucket.site.id
  rule { apply_server_side_encryption_by_default { sse_algorithm = "AES256" } }
}
resource "aws_cloudfront_origin_access_control" "site" {
  name = "pranay-site-${var.name_suffix}"
  origin_access_control_origin_type = "s3"
  signing_behavior = "always"
  signing_protocol = "sigv4"
}
resource "aws_cloudfront_distribution" "site" {
  enabled = true
  default_root_object = "index.html"
  origin {
    domain_name = aws_s3_bucket.site.bucket_regional_domain_name
    origin_id = "private-s3"
    origin_access_control_id = aws_cloudfront_origin_access_control.site.id
  }
  default_cache_behavior {
    target_origin_id = "private-s3"
    viewer_protocol_policy = "redirect-to-https"
    allowed_methods = ["GET", "HEAD"]
    cached_methods = ["GET", "HEAD"]
    compress = true
    forwarded_values { query_string = false, cookies { forward = "none" } }
    min_ttl = 0
    default_ttl = 3600
    max_ttl = 86400
  }
  restrictions { geo_restriction { restriction_type = "none" } }
  viewer_certificate { cloudfront_default_certificate = true }
}
data "aws_iam_policy_document" "origin" {
  statement {
    sid = "AllowCloudFrontOAC"
    actions = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.site.arn}/*"]
    principals { type = "Service", identifiers = ["cloudfront.amazonaws.com"] }
    condition {
      test = "StringEquals"
      variable = "AWS:SourceArn"
      values = [aws_cloudfront_distribution.site.arn]
    }
  }
}
resource "aws_s3_bucket_policy" "origin" {
  bucket = aws_s3_bucket.site.id
  policy = data.aws_iam_policy_document.origin.json
  depends_on = [aws_s3_bucket_public_access_block.site]
}
output "bucket_name" { value = aws_s3_bucket.site.id }
output "cloudfront_domain" { value = aws_cloudfront_distribution.site.domain_name }
