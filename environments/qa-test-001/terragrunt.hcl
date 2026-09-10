include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules//demo-app"
}

remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite"
  }
  config = {
    bucket                               = "terragrunt-demo-tfstate-227120241369"
    key                                  = "${path_relative_to_include()}/terraform.tfstate"
    region                               = "us-east-2"
    encrypt                              = true
    dynamodb_table                       = "terraform-state-lock"
    skip_bucket_versioning               = true
    skip_bucket_root_access              = true
    skip_bucket_enforced_tls             = true
    skip_bucket_public_access_blocking   = true
    enable_lock_table_ssencryption       = false
  }
}

inputs = {
  environment   = "qa-test-001"
  app_name      = "arine-demo"
  replica_count = 1
}
