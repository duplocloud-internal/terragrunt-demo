resource "random_id" "deployment_id" {
  byte_length = 4

  keepers = {
    environment = var.environment
    app_name    = var.app_name
  }
}

resource "random_string" "api_key" {
  length  = 32
  special = false

  keepers = {
    environment = var.environment
  }
}

resource "random_pet" "instance_names" {
  count  = var.replica_count
  length = 2

  keepers = {
    environment = var.environment
    index       = count.index
  }
}
