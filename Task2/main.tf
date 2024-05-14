terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.27.0"
    }
  }
}

provider "google" {
  # Configuration option
project = "steady-method-416401"
region = "us-east1"
zone = "us-east1-b"
credentials = "steady-method-416401-bbc4e84f5229.json"
}  

resource "google_compute_network" "home-work-2-tf" {
  project                                   = "steady-method-416401"
  name                                      = "home-work-2-tf"
  auto_create_subnetworks                   = false
  network_firewall_policy_enforcement_order = "BEFORE_CLASSIC_FIREWALL"
}

output "home-work-2-tf" {
  value = "${google_compute_network.home-work-2-tf.id}"
  description = "home-work-2-tf"
}
resource "google_compute_subnetwork" "hw2-2-subnet" {
  project                  = "steady-method-416401"
  region                   = "us-east1"
  network                  = google_compute_network.home-work-2-tf.id
  name                     = "hw2-2-subnet"
  ip_cidr_range            = "10.187.0.0/24"
  
}

resource "google_compute_instance" "vm-hw2-2" {
  project      = "steady-method-416401"
  name         = "vm-hw2-2"
  machine_type = "e2-micro"
  zone         = "us-east1-b"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.hw2-2-subnet.id
    access_config {
    }
  }
  
}
resource "google_compute_firewall" "public-ssh-hw-2" {
  project = "steady-method-416401"
  name = "public-ssh-hw-2"
  network = google_compute_network.home-work-2-tf.id
  allow {
    protocol = "tcp"
    ports = ["22","80","443"]
  }
  source_ranges = ["0.0.0.0/0"]
  
}
