include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules//demo-app"
}

inputs = {
  environment   = "prod"
  app_name      = "arine-demo"
  replica_count = 3
}
