variable "cluster_name" {
  description = "ECS cluster name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for ECS tasks"
  type        = list(string)
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "enable_container_insights" {
  description = "Enable CloudWatch Container Insights"
  type        = bool
  default     = true
}

variable "app_name" {
  description = "Application name"
  type        = string
  default     = "demo-app"
}

variable "app_image" {
  description = "Docker image for the app"
  type        = string
  default     = "nginx:alpine"
}

variable "app_port" {
  description = "Application port"
  type        = number
  default     = 80
}

variable "desired_count" {
  description = "Number of tasks to run"
  type        = number
  default     = 2
}

variable "cpu" {
  description = "Task CPU units"
  type        = number
  default     = 256
}

variable "memory" {
  description = "Task memory (MB)"
  type        = number
  default     = 512
}
