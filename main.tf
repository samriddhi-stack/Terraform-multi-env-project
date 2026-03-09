# Default VPC (existing)
resource "aws_default_vpc" "default" {
  tags = {
    Name = "default-vpc"
  }
}

# Key Pair
resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = file("~/.ssh/id_ed25519.pub") # Update with your key path
}

# Security Group
resource "aws_security_group" "terrasecurity" {
  name        = "allow-ports"
  description = "This SG is to open ports for EC2 Instance"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "All outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-ports"
  }
}

# DynamoDB Table (for state locking)
resource "aws_dynamodb_table" "name" {
  name         = "second-project-terraform"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name = "terraform-lock-table"
  }
}

# EC2 Instance
resource "aws_instance" "my_instance" {
  ami                    = "ami-0b6c6ebed2801a5cb" # Ubuntu 24.04 LTS
  instance_type          = var.instance_type
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.terrasecurity.id]
  subnet_id              = data.aws_subnet.default.id

  tags = {
    Name = "terra-automate"
  }
}

# S3 Bucket (for root)
resource "aws_s3_bucket" "my-bucket" {
  bucket = "second-project10083723847"

  tags = {
    Name        = "second-project10083723847"
    Environment = "root"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "my-bucket" {
  bucket = aws_s3_bucket.my-bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Data source for default subnet
data "aws_subnet" "default" {
  id = "subnet-0a680fcad98d29a17" # From your state file
}
