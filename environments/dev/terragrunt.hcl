include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules//demo-app"
}

inputs = {
  environment   = "dev"
  app_name      = "arine-demo"
  replica_count = 1
}
