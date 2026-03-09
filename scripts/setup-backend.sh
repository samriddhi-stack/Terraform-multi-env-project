#!/bin/bash

# Create S3 bucket for Terraform state
aws s3 mb s3://second-project-terraform-state --region us-east-1

# Enable versioning on the bucket
aws s3api put-bucket-versioning \
    --bucket second-project-terraform-state \
    --versioning-configuration Status=Enabled

# Create DynamoDB table for state locking
aws dynamodb create-table \
    --table-name second-project-terraform \
    --attribute-definitions AttributeName=LockID,AttributeType=S \
    --key-schema AttributeName=LockID,KeyType=HASH \
    --billing-mode PAY_PER_REQUEST \
    --region us-east-1

echo "Backend infrastructure created successfully!"
