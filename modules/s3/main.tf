resource "aws_s3_bucket" "name" {
  bucket = "${var.environment}-${var.project_name}${var.bucket_suffix}"

  tags = {
    Name        = "${var.environment}-${var.project_name}${var.bucket_suffix}"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "name" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
