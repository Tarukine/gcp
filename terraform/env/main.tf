module "vpc" {
  source        = "../modules/vpc"
  network_name  = "${local.name}-network"
  subent_name   = "${local.name}-subnet"
  region        = local.region
  ip_cidr_range = "192.168.0.0/24"
}

module "sql" {
  source            = "../modules/sql"
  db_name           = "${local.name}-sql"
  db_instance_name  = "${local.name}-sql-instance"
  db_user_name      = "${local.name}-sql-user"
  project           = local.project
  region            = local.region
  database_version  = "POSTGRES_13"
  tier              = "db-f1-micro"
  availability_type = "REGIONAL"
  host              = local.name
  password          = local.name
}
