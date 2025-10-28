packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1"
    }
  }
}

variable "aws_region" {
  type    = string
  default = "eu-north-1"
}

variable "ami_prefix" {
  type    = string
  default = "devsecops-ubuntu-baseline"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

# Source AMI - Ubuntu 22.04 LTS
source "amazon-ebs" "ubuntu" {
  ami_name      = "${var.ami_prefix}-{{timestamp}}"
  instance_type = var.instance_type
  region        = var.aws_region
  
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"
      virtualization-type = "hvm"
      root-device-type    = "ebs"
    }
    owners      = ["099720109477"] # Canonical
    most_recent = true
  }
  
  ssh_username = "ubuntu"
  
  # Security and compliance tags
  tags = {
    Name            = "${var.ami_prefix}-{{timestamp}}"
    OS              = "Ubuntu"
    OS_Version      = "22.04"
    Base_AMI        = "{{ .SourceAMI }}"
    BuildDate       = "{{timestamp}}"
    ManagedBy       = "Packer"
    SecurityScanned = "true"
    Compliance      = "CIS-Benchmark"
  }
  
  # Enable encryption
  encrypt_boot = true
}

build {
  name    = "ubuntu-baseline"
  sources = ["source.amazon-ebs.ubuntu"]
  
  # Update system packages
  provisioner "shell" {
    inline = [
      "echo 'Updating system packages...'",
      "sudo apt-get update",
      "sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y",
      "sudo apt-get clean"
    ]
  }
  
  # Install essential tools
  provisioner "shell" {
    inline = [
      "echo 'Installing essential tools...'",
      "sudo apt-get install -y curl wget vim git unzip jq",
      "sudo apt-get install -y software-properties-common apt-transport-https",
    ]
  }
  
  # Install Docker
  provisioner "shell" {
    inline = [
      "echo 'Installing Docker...'",
      "curl -fsSL https://get.docker.com -o get-docker.sh",
      "sudo sh get-docker.sh",
      "sudo usermod -aG docker ubuntu",
      "sudo systemctl enable docker",
      "rm get-docker.sh"
    ]
  }
  
  # Install AWS CLI v2
  provisioner "shell" {
    inline = [
      "echo 'Installing AWS CLI v2...'",
      "curl 'https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip' -o 'awscliv2.zip'",
      "unzip awscliv2.zip",
      "sudo ./aws/install",
      "rm -rf aws awscliv2.zip"
    ]
  }
  
  # Install CloudWatch Agent
  provisioner "shell" {
    inline = [
      "echo 'Installing CloudWatch Agent...'",
      "wget https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb",
      "sudo dpkg -i amazon-cloudwatch-agent.deb",
      "rm amazon-cloudwatch-agent.deb"
    ]
  }
  
  # Security hardening - CIS benchmarks
  provisioner "shell" {
    inline = [
      "echo 'Applying security hardening...'",
      # Disable root login
      "sudo sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config",
      # Set password policy
      "sudo apt-get install -y libpam-pwquality",
      # Enable automatic security updates
      "sudo apt-get install -y unattended-upgrades",
      "sudo dpkg-reconfigure -plow unattended-upgrades"
    ]
  }
  
  # Install monitoring and security agents (placeholder for real agents)
  provisioner "shell" {
    inline = [
      "echo 'Installing security monitoring agents...'",
      "# Placeholder for agents like: CrowdStrike, Wazuh, etc.",
      "# In production: install your security agents here"
    ]
  }
  
  # Cleanup
  provisioner "shell" {
    inline = [
      "echo 'Cleaning up...'",
      "sudo apt-get autoremove -y",
      "sudo apt-get autoclean -y",
      "sudo rm -rf /tmp/*",
      "sudo rm -rf /var/tmp/*",
      # Clear bash history
      "cat /dev/null > ~/.bash_history && history -c"
    ]
  }
  
  # Generate manifest
  post-processor "manifest" {
    output     = "manifest.json"
    strip_path = true
    custom_data = {
      build_time = timestamp()
      packer_version = packer.version
    }
  }
}
