# Ubuntu Baseline AMI

Golden AMI with security hardening, monitoring agents, and compliance scanning.

## Features
- Ubuntu 22.04 LTS base
- Docker pre-installed
- AWS CLI v2
- CloudWatch Agent
- CIS benchmark hardening
- Automatic security updates
- Encrypted EBS volumes

## Build
```bash
cd packer/ubuntu
packer init .
packer validate ubuntu-baseline.pkr.hcl
packer build ubuntu-baseline.pkr.hcl
```

## Variables

- `aws_region`: AWS region (default: eu-north-1)
- `ami_prefix`: AMI name prefix
- `instance_type`: Build instance type (default: t3.micro)

## Security

AMIs are automatically tagged for Inspector scanning and Security Hub compliance checks.
