output "vpc_id" {
  description = "VPC ID"
  value       = aws_default_vpc.default.id
}

output "ec2_public_ip" {
  description = "EC2 instance public IP"
  value       = aws_instance.my_instance.public_ip
}

output "ec2_public_dns" {
  description = "EC2 instance public DNS"
  value       = aws_instance.my_instance.public_dns
}

output "s3_buckets" {
  description = "S3 bucket names"
  value = {
    root = aws_s3_bucket.my-bucket.id
    dev  = module.dev-app.s3_bucket_name
    stg  = module.stg-app.s3_bucket_name
    prd  = module.prd-app.s3_bucket_name
  }
}
