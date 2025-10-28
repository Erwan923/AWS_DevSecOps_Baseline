# CI/CD Workflows

## Workflows

### 1. `terraform-ci.yml` - Infrastructure Deployment
**Triggers:** Push/PR to main affecting `terraform/`

**Jobs:**
1. **security-scan**: tfsec + Checkov security analysis
2. **terraform-plan**: Validate and plan changes
3. **terraform-apply**: Deploy to AWS (main branch only, requires approval)

**Secrets required:**
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`

### 2. `packer-build.yml` - Golden AMI Pipeline
**Triggers:** Push to main affecting `packer/` or manual dispatch

**Jobs:**
1. Build Ubuntu baseline AMI with Packer
2. Trigger Inspector vulnerability scan
3. Check Security Hub for critical findings
4. Tag AMI as validated if clean
5. Fail pipeline if critical vulnerabilities found

### 3. `lint.yml` - Code Quality
**Triggers:** Pull requests

**Jobs:**
- Terraform format validation
- Markdown linting

## Setup

1. Add AWS credentials as GitHub secrets:
   - Settings → Secrets → Actions
   - Add `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY`

2. Enable GitHub Actions:
   - Settings → Actions → General
   - Allow all actions

3. Configure branch protection (optional):
   - Require status checks before merging
   - Require approval for terraform-apply
