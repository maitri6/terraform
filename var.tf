#provider
variable "projectid" {}
variable "credential_file_path" {}
provider "google" {
  credentials=file(var.credential_file_path)
  project     = var.projectid
  region      = "us-central1"
zone    = "us-central1-c"
}
resource "google_compute_instance" "default" {
  name         = "test"
  machine_type = "e2-medium"
  zone         = "us-central1-a"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  network_interface {
        network ="default"
        access_config {

        }
  }
}
resource "google_compute_network" "private-net"{
  name="private-net"
  auto_create_subnetworks=false
}
resource "google_compute_subnetwork" "private"{
  name="private"
  ip_cidr_range="10.0.1.0/24"
  network=google_compute_network.private-net.id
}