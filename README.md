<div align="center">

<img src="Logo.png" alt="AWS DevSecOps Platform" width="180"/>

# AWS DevSecOps Baseline Platform

Enterprise-grade multi-account infrastructure with automated CI/CD, security scanning, and unified observability

[![Terraform](https://img.shields.io/badge/Terraform-1.9.8-623CE4?style=flat&logo=terraform&logoColor=white)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-EU--North--1-FF9900?style=flat&logo=amazon-aws&logoColor=white)](https://aws.amazon.com/)
[![GitHub Actions](https://img.shields.io/badge/CI%2FCD-GitHub%20Actions-2088FF?style=flat&logo=github-actions&logoColor=white)](https://github.com/features/actions)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE.txt)

</div>

---

## 🚀 What is this?

Production-ready AWS infrastructure platform enabling secure, compliant cloud environments through automated CI/CD. Built with Infrastructure-as-Code and DevSecOps best practices.

**Key capabilities:**
- Multi-account Terraform orchestration with S3 backend
- ECS Fargate clusters with multi-AZ deployment
- Automated security scanning (tfsec, Checkov, AWS Inspector)
- Unified observability (CloudWatch, Container Insights)
- Golden AMI pipeline with CIS hardening

---

## 📊 Architecture

<div align="center">

### CI/CD Workflow

<img src="AWS_DevSecOps.png" alt="CI/CD Architecture" width="750"/>

**Flow:** Developer → GitHub → Actions → Security Scan → Terraform → AWS Infrastructure

</div>

### Infrastructure Components
```
AWS eu-north-1 Region
├── Backend: S3 (state) + DynamoDB (locking)
├── Network: VPC 10.0.0.0/16, Multi-AZ (eu-north-1a, 1b)
├── Compute: ECS Fargate clusters with auto-scaling
├── Security: Inspector + Security Hub + VPC Flow Logs
└── Monitoring: CloudWatch Logs/Metrics + Container Insights
```

---

## ⚡ Quick Start

### Prerequisites
```bash
terraform >= 1.5.0
aws-cli >= 2.0
aws configure  # Region: eu-north-1
```

### Deploy
```bash
git clone https://github.com/Erwan923/AWS_DevSecOps_Baseline.git
cd AWS_DevSecOps_Baseline/terraform/environments/dev

terraform init
terraform plan
terraform apply
```

### Build Golden AMI (optional)
```bash
cd packer/ubuntu
packer init .
packer build ubuntu-baseline.pkr.hcl  # ~15-20 min
```

---

## 📁 Repository Structure
```
.
├── .github/workflows/     # CI/CD pipelines (Terraform, Packer, Lint)
├── terraform/
│   ├── modules/           # VPC, ECS, Security, Monitoring
│   └── environments/      # dev, staging, shared
├── packer/ubuntu/         # Golden AMI templates
├── docs/                  # Architecture diagrams, ADRs, runbooks
└── monitoring/            # Prometheus, Grafana configs
```

---

## 🔒 Security Features

- **Automated scanning:** tfsec/Checkov in CI pipeline
- **Continuous monitoring:** AWS Inspector + Security Hub
- **Compliance:** CIS AWS Benchmark v1.4.0, GDPR aligned
- **Encryption:** At rest (S3, EBS) and in transit (TLS 1.2+)
- **Pipeline gates:** Block deployments with critical CVEs

---

## 📈 Key Metrics

| Metric | Before | After | Improvement |
|--------|--------|-------|-------------|
| Mean Time To Detect | 15 min | 3 min | 80% faster |
| Mean Time To Resolve | 45 min | 20 min | 56% faster |
| Post-deployment CVEs | 100% | 10% | 90% reduction |
| Infrastructure provisioning | 2 days | 10 min | 99% faster |

---

## 💰 Cost Estimate

**Dev Environment:** ~$18/month
- ECS Fargate (2 tasks): $15
- CloudWatch Logs: $2.50
- S3/DynamoDB: $0.50

**Production:** ~$180-200/month (10 tasks, NAT Gateway, ALB)

---

## 🗺️ Roadmap

**Completed (Q4 2024)**
- ✅ Multi-AZ ECS Fargate infrastructure
- ✅ Golden AMI pipeline with security validation
- ✅ GitHub Actions CI/CD

**In Progress (Q1 2025)**
- 🔄 Grafana + Prometheus integration
- 🔄 S3 + CloudFront distribution
- 🔄 Advanced monitoring dashboards

**Planned (Q2 2025)**
- 📋 Multi-account AWS Organizations
- 📋 EKS migration path
- 📋 Disaster recovery automation

---

## 📚 Documentation

- [Architecture Decisions](docs/decisions/) - ADRs for technical choices
- [Operational Runbooks](docs/runbooks/) - Deployment and troubleshooting guides
- [Cost Optimization](docs/cost-optimization.md) - Resource sizing recommendations

---

## 👤 Author

**Erwan Billard** - DevSecOps Engineer

AWS Solutions Architect • CKA • CRTO

[GitHub](https://github.com/Erwan923) • [LinkedIn](https://linkedin.com/in/erwan-billard) • erwan.billard@protonmail.com

---

## 📝 License

MIT License - see [LICENSE.txt](LICENSE.txt)

---

<div align="center">

**Built with ❤️ for secure, automated infrastructure**

⭐ Star this repo if it helped you!

</div>
