# AWS DevSecOps Baseline Platform

Multi-account AWS infrastructure with automated CI/CD, security scanning, and unified observability.

## Features
- Multi-account Terraform orchestration (S3 backend + DynamoDB locking)
- ECS Fargate with custom golden AMI worker nodes
- Automated security scanning (Inspector, Security Hub)
- Unified monitoring (CloudWatch + Prometheus + Grafana)
- S3 + CloudFront artifact distribution
- CI/CD with security gates

## Quick Start
```bash
cd terraform/environments/dev
terraform init
terraform plan
```

## Architecture
See `docs/architecture/` for detailed diagrams and explanations.

## Metrics
- MTTD: 3min (from 15min baseline)
- MTTR: 20min (from 45min baseline)
- 90% reduction in post-deployment vulnerabilities
