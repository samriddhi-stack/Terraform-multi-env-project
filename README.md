# 🏗️ Multi-Environment AWS Infrastructure with Terraform

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-FF9900?style=for-the-badge&logo=amazonaws&logoColor=white)

## 📋 Overview

This project provisions a **complete multi-environment AWS infrastructure** using Terraform. It demonstrates Infrastructure as Code (IaC) best practices including **modular design**, **remote state management**, and **environment-specific configurations** for development (dev), staging (stg), and production (prd).

## 🏗️ Infrastructure Created

| Resource | dev | stg | prd | Root |
|----------|-----|-----|-----|------|
| EC2 Instances | 1 | 2 | 3 | 1 |
| S3 Buckets | 1 | 1 | 1 | 1 |
| DynamoDB Tables | 1 | 1 | 1 | 1 |
| Security Groups | 1 | 1 | 1 | 1 |
| VPC | Default | Default | Default | Default |
| **Total** | **5** | **6** | **7** | **5** |

## 🛠️ Technologies Used

| Category | Tools |
|----------|-------|
| **Infrastructure as Code** | Terraform |
| **Cloud Provider** | AWS (EC2, S3, DynamoDB, IAM) |
| **State Management** | S3 Backend + DynamoDB Locking |
| **Version Control** | Git |
| **Scripting** | Bash |

## 📁 Project Structure

```

terraform-multi-env-project/
├── environments/          # Environment-specific configs
│   ├── dev/
│   ├── stg/
│   └── prd/
├── modules/               # Reusable infrastructure modules
│   ├── vpc/
│   ├── ec2/
│   └── s3/
├── main.tf                # Root configuration
├── variables.tf           # Input variables
├── outputs.tf             # Output values
├── provider.tf            # AWS provider config
└── terraform.tfvars.example

```
## 🚀 Deployment Instructions

### Prerequisites
- AWS account with IAM user (programmatic access)
- AWS CLI configured (`aws configure`)
- Terraform installed (v1.0+)
- Git

### 1. Clone the Repository
```bash
git clone https://github.com/your-username/terraform-multi-env-project.git
cd terraform-multi-env-project
```

### 2. Set Up Remote State Backend

```bash
chmod +x scripts/setup-backend.sh
./scripts/setup-backend.sh
```

### 3. Deploy to an Environment
For Development
```bash
cd environments/dev
terraform init -backend-config=backend.tfvars
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars -auto-approve
```

For Staging:

```bash
cd environments/stg
terraform init -backend-config=backend.tfvars
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars -auto-approve
```

For Production:

```bash
cd environments/prd
terraform init -backend-config=backend.tfvars
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars -auto-approve
```

### 4. Verify Resources

```bash
terraform state list
terraform output
```

## 📸 Screenshots

| Screenshot | Description |
|------------|-------------|
| [`terraform-apply-success.md`](screenshots/terraform-apply-success.md) | Terraform apply successful with 18 resources created |
| [`aws-ec2-instances.md`](screenshots/aws-ec2-instances.md) | 7 EC2 instances running across environments |
| [`aws-s3-buckets.md`](screenshots/aws-s3-buckets.md) | 4 S3 buckets created (root + dev/stg/prd) |
| [`aws-dynamodb-tables.md`](screenshots/aws-dynamodb-tables.md) | 4 DynamoDB tables including state locking |
| [`terraform-state-list.md`](screenshots/terraform-state-list.md) | Complete list of all resources managed by Terraform |
| [`terraform-destroy.md`](screenshots/terraform-destroy.md) | Clean destroy of all 18 resources |

## 📊 Resource Details from Actual Deployment
### EC2 Instances (7 total)
- dev-terra-automate    : 100.31.96.161 </br>
- stg-terra-automate[0] : 98.82.114.138 </br>
- stg-terra-automate[1] : 3.236.6.137 </br>
- prd-terra-automate[0] : 44.213.64.113 </br>
- prd-terra-automate[1] : 100.48.44.196 </br>
- prd-terra-automate[2] : 3.238.251.20 </br>
- terra-automate (root) : 100.26.135.82 </br>

### S3 Buckets (4 total)
- second-project10083723847 (root) </br>
- dev-second-project10083723847 (dev) </br>
- stg-second-project10083723847 (stg) </br>
- prd-second-project10083723847 (prd) </br>

### DynamoDB Tables (4 total)
- second-project-terraform (root/locking) </br>
- dev-second-project10083723847-table </br>
- stg-second-project10083723847-table </br>
- prd-second-project10083723847-table </br>

## 📚 What I Learned
- **Terraform Core Concepts:** Providers, resources, data sources, variables, outputs
- **State Management:** Remote state storage with S3 and DynamoDB locking
- **Modular Design:** Creating reusable modules for EC2 and S3
- **Multi-Environment Strategy:** Managing dev/stg/prd with separate tfvars files
- **IAM and Security:** Security groups with least-privilege rules
- **Terraform Workflow:** init → plan → apply → destroy

## 🧹 Clean Up
To avoid ongoing charges, destroy all resources:
```bash
# Destroy each environment
cd environments/dev && terraform destroy -var-file=terraform.tfvars -auto-approve
cd environments/stg && terraform destroy -var-file=terraform.tfvars -auto-approve
cd environments/prd && terraform destroy -var-file=terraform.tfvars -auto-approve

# Delete backend resources
aws s3 rb s3://second-project-terraform-state --force
aws dynamodb delete-table --table-name second-project-terraform
```
### Credits
This project was built while following Shubham Londhe's Terraform for DevOps series.
