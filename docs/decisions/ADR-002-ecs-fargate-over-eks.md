# ADR-002: ECS Fargate Instead of EKS for Initial Deployment

## Status
Accepted

## Context
Need container orchestration for microservices workloads. Options: ECS, EKS, or plain EC2.

## Decision
Start with ECS Fargate, with EKS module ready for future migration if needed.

## Rationale

**ECS Fargate Advantages:**
- 60% lower cost vs EKS for small workloads
- No control plane management ($0.10/hour saved)
- Faster time-to-production (no cluster setup)
- Native AWS integration (IAM, CloudWatch, Security Hub)
- Sufficient for current requirements

**When to Migrate to EKS:**
- Need Kubernetes-specific features (Operators, CRDs)
- Multi-cloud portability required
- Advanced networking (service mesh, network policies)
- Team expertise shifts to Kubernetes

**Cost Comparison (2 tasks, 0.25 vCPU, 512MB):**
- ECS Fargate: ~$15/month
- EKS: ~$90/month (control plane + nodes)

## Consequences

**Positive:**
- Immediate cost savings
- Simpler operations (no node management)
- Faster deployment cycles
- Built-in AWS CloudWatch integration

**Negative:**
- ECS-specific knowledge required
- Less portable than Kubernetes
- Limited advanced scheduling features
- Vendor lock-in to AWS

**Migration Path:**
- EKS module already scaffolded in `terraform/modules/eks/`
- Same VPC, subnets, and security groups reusable
- Container images portable between ECS and EKS

## Date
2025-10-28
