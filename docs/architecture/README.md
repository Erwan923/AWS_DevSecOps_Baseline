# Architecture Overview

## High-Level Architecture
```
┌─────────────────────────────────────────────────────────┐
│                    GitHub Repository                     │
│                   (Source Control)                       │
└────────────────────┬────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────┐
│              GitHub Actions (CI/CD)                      │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐  │
│  │   Security   │  │   Terraform  │  │    Packer    │  │
│  │    Scan      │  │     Plan     │  │  AMI Build   │  │
│  └──────────────┘  └──────────────┘  └──────────────┘  │
└────────────────────┬────────────────────────────────────┘
                     │
                     ▼
┌─────────────────────────────────────────────────────────┐
│                  AWS Account (eu-north-1)                │
│                                                          │
│  ┌──────────────────────────────────────────────────┐  │
│  │              VPC (10.0.0.0/16)                    │  │
│  │  ┌─────────────────┐    ┌─────────────────┐     │  │
│  │  │  Public Subnet  │    │  Public Subnet  │     │  │
│  │  │   10.0.101/24   │    │   10.0.102/24   │     │  │
│  │  │  (eu-north-1a)  │    │  (eu-north-1b)  │     │  │
│  │  └────────┬────────┘    └────────┬────────┘     │  │
│  │           │                       │              │  │
│  │  ┌────────▼────────┐    ┌────────▼────────┐     │  │
│  │  │ Private Subnet  │    │ Private Subnet  │     │  │
│  │  │   10.0.1.0/24   │    │   10.0.2.0/24   │     │  │
│  │  │  (eu-north-1a)  │    │  (eu-north-1b)  │     │  │
│  │  │                 │    │                 │     │  │
│  │  │  ┌───────────┐  │    │  ┌───────────┐  │     │  │
│  │  │  │ECS Fargate│  │    │  │ECS Fargate│  │     │  │
│  │  │  │   Tasks   │  │    │  │   Tasks   │  │     │  │
│  │  │  └───────────┘  │    │  └───────────┘  │     │  │
│  │  └─────────────────┘    └─────────────────┘     │  │
│  └──────────────────────────────────────────────────┘  │
│                                                          │
│  ┌──────────────────────────────────────────────────┐  │
│  │           Supporting Services                     │  │
│  │  • S3 (Terraform State)                          │  │
│  │  • DynamoDB (State Locking)                      │  │
│  │  • CloudWatch (Logs & Metrics)                   │  │
│  │  • Security Hub (Findings Aggregation)           │  │
│  │  • Inspector (Vulnerability Scanning)            │  │
│  └──────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────┘
```

## Components

### Infrastructure Layer
- **VPC Module**: Multi-AZ networking with public/private subnets
- **ECS Module**: Fargate-based container orchestration
- **Backend**: S3 + DynamoDB for Terraform state management

### CI/CD Pipeline
- **Security Scanning**: tfsec, Checkov for IaC security
- **Terraform Workflow**: Plan → Approve → Apply
- **Packer Pipeline**: AMI build → Inspector scan → Validation

### Security & Compliance
- **Inspector**: Continuous vulnerability scanning
- **Security Hub**: Centralized security findings
- **Golden AMIs**: Hardened Ubuntu images with CIS benchmarks
- **Flow Logs**: VPC network traffic monitoring

### Monitoring
- **CloudWatch Logs**: Centralized log aggregation
- **Container Insights**: ECS metrics and dashboards
- **Custom Metrics**: Application-level observability

## Design Principles

1. **Multi-AZ**: All resources deployed across 2 availability zones
2. **Infrastructure as Code**: 100% Terraform-managed
3. **Security by Default**: Encryption, private subnets, security scanning
4. **Immutable Infrastructure**: Golden AMIs, container images
5. **Observable**: Comprehensive logging and monitoring
