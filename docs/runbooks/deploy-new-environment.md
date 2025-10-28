# Runbook: Deploy New Environment

## Prerequisites
- AWS credentials configured
- Terraform >= 1.5.0 installed
- Access to S3 state bucket

## Steps

### 1. Create Environment Directory
```bash
cd terraform/environments
cp -r dev staging  # or prod
cd staging
```

### 2. Update Configuration
Edit `main.tf`:
```hcl
module "vpc" {
  vpc_name    = "devsecops-staging"  # Change name
  environment = "staging"             # Change env
  # ... adjust CIDR blocks if needed
}
```

### 3. Update Backend Key
```hcl
backend "s3" {
  key = "staging/terraform.tfstate"  # Change key
}
```

### 4. Initialize and Deploy
```bash
terraform init
terraform plan -out=tfplan
# Review plan carefully
terraform apply tfplan
```

### 5. Verify Deployment
```bash
# Check VPC
aws ec2 describe-vpcs --filters "Name=tag:Name,Values=devsecops-staging"

# Check ECS Cluster
aws ecs list-clusters
aws ecs describe-clusters --clusters devsecops-staging
```

### 6. Configure Monitoring
- Check CloudWatch dashboard
- Verify Container Insights enabled
- Test VPC Flow Logs

## Rollback
```bash
terraform destroy
# Confirm with: yes
```

## Troubleshooting

**Issue:** `Error: Error locking state`
**Solution:** 
```bash
# Find lock ID in error message
aws dynamodb delete-item --table-name terraform-state-lock --key '{"LockID":{"S":"erwan-tfstate-devsecops/staging/terraform.tfstate"}}'
```

**Issue:** `Insufficient subnet capacity`
**Solution:** Adjust CIDR blocks to avoid overlaps with other VPCs

## Post-Deployment
- [ ] Update DNS records if needed
- [ ] Configure alerts in CloudWatch
- [ ] Document in architecture diagrams
- [ ] Update team wiki
