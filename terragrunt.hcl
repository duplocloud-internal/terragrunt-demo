# Root terragrunt.hcl — shared backend + provider config for all environments.
# Terragrunt auto-creates the S3 bucket and DynamoDB table on first run.

locals {
  account_id = get_aws_account_id()
  region     = get_env("AWS_DEFAULT_REGION", "us-east-2")
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = "terragrunt-demo-tfstate-${local.account_id}"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.region
    encrypt        = true
    dynamodb_table = "terraform-state-lock"

    # Terragrunt auto-creates these if missing.
    skip_bucket_versioning         = false
    enable_lock_table_ssencryption = true
  }
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
terraform {
  required_version = ">= 1.5"
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "random" {}
EOF
}
