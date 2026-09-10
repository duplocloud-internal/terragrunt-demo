# Root terragrunt.hcl — shared backend + provider config for all environments.
# Terragrunt auto-creates the S3 bucket and DynamoDB table on first run.

locals {
  region = "us-east-2"
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket         = "terragrunt-arine-tfstate"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = local.region
    encrypt        = true
    dynamodb_table = "terraform-state-lock"

    # Skip bucket policy checks — avoids needing s3:GetBucketPolicy
    skip_bucket_versioning         = true
    skip_bucket_root_access              = true
    skip_bucket_enforced_tls             = true
    skip_bucket_public_access_blocking   = true
    enable_lock_table_ssencryption = false
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
