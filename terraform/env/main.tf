module "vpc" {
  source        = "../modules/vpc"
  network_name  = "${local.name}-network"
  subent_name   = "${local.name}-subnet"
  region        = local.region
  ip_cidr_range = "192.168.0.0/24"
}
