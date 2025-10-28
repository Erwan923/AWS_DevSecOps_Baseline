#!/bin/bash
set -e

echo "Building Ubuntu baseline AMI..."

# Initialize Packer
packer init .

# Validate template
echo "Validating Packer template..."
packer validate ubuntu-baseline.pkr.hcl

# Build AMI
echo "Building AMI..."
packer build ubuntu-baseline.pkr.hcl

echo "Build complete! Check manifest.json for AMI ID."
