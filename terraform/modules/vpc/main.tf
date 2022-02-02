resource "google_compute_network" "common" {
  name                    = var.network_name
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "common" {
  name          = var.subent_name
  region        = var.region
  ip_cidr_range = var.ip_cidr_range
  network       = google_compute_network.common.id
}
