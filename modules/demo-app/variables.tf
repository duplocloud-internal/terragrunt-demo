variable "environment" {
  description = "Environment name (dev, staging, prod)"
  type        = string
}

variable "app_name" {
  description = "Application name for this deployment"
  type        = string
  default     = "arine-demo"
}

variable "replica_count" {
  description = "Simulated replica count for this environment"
  type        = number
  default     = 1
}
