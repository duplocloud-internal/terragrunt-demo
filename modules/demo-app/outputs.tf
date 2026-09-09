output "deployment_id" {
  description = "Unique ID for this deployment"
  value       = "${var.app_name}-${var.environment}-${random_id.deployment_id.hex}"
}

output "environment" {
  description = "Environment name"
  value       = var.environment
}

output "api_key" {
  description = "Generated API key for this environment"
  value       = random_string.api_key.result
  sensitive   = true
}

output "instance_names" {
  description = "Names of deployed instances"
  value       = random_pet.instance_names[*].id
}

output "replica_count" {
  description = "Number of replicas"
  value       = var.replica_count
}
