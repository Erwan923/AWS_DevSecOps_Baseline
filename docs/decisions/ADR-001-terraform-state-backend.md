# ADR-001: Terraform State Backend with S3 and DynamoDB

## Status
Accepted

## Context
Need centralized, versioned, and locked state management for Terraform across multiple environments and team members.

## Decision
Use AWS S3 for state storage with DynamoDB for state locking.

## Rationale

**S3 Benefits:**
- Versioning enabled: rollback capability
- Encryption at rest (SSE-S3)
- High durability (99.999999999%)
- Cost-effective (~$0.023/GB/month)

**DynamoDB Benefits:**
- Prevents concurrent modifications
- Automatic locking/unlocking
- On-demand pricing (no fixed costs)

**Alternatives Considered:**
- Terraform Cloud: Cost prohibitive ($20/user/month)
- Local state: No collaboration, no locking
- Git-committed state: Security risk (contains secrets)

## Consequences

**Positive:**
- Safe concurrent operations
- Complete audit trail via S3 versioning
- State recovery in case of corruption
- Multi-account support via separate keys

**Negative:**
- Requires AWS account setup before Terraform use
- Manual backend initialization for new environments
- Network dependency (requires AWS connectivity)

## Implementation
```hcl
terraform {
  backend "s3" {
    bucket         = "erwan-tfstate-devsecops"
    key            = "env/terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}
```

## Date
2025-10-28
