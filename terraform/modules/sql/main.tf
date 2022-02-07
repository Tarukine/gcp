resource "google_sql_database" "sql" {
  name     = var.db_name
  instance = google_sql_database_instance.sql.name
  project  = var.project
}

resource "google_sql_database_instance" "sql" {
  name                = var.db_instance_name
  region              = var.region
  project             = var.project
  database_version    = var.database_version
  deletion_protection = "false"
  settings {
    tier              = var.tier
    availability_type = var.availability_type
  }
}

resource "google_sql_user" "user" {
  name     = var.db_user_name
  instance = google_sql_database_instance.sql.name
  host     = var.host
  password = var.password
}
