resource "google_compute_firewall" "allow-http" {
  name = "allow-http"
  network = google_compute_network.europe-vpc-tf.id
  allow {
    protocol = "tcp"
    ports = ["80"]
  }
  source_ranges = ["172.16.1.0/24", "172.16.2.0/24", "192.168.1.0/24"]
  }

resource "google_compute_firewall" "me-2-asia" {
  name = "me-2-asia"
  network = google_compute_network.asia-vpc-tf.id
  allow {
    protocol = "tcp"
    ports = ["3389"]
  }
  source_ranges = ["0.0.0.0/0"]
}

  resource "google_compute_firewall" "me-2-americas" {
  name = "me-2-americas"
  network = google_compute_network.us-vpc-tf.id
  allow {
    protocol = "tcp"
    ports = ["3389"]
  }
  source_ranges = ["0.0.0.0/0"]
  }