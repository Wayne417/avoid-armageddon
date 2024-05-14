resource "google_compute_network_peering" "peering-america-2-europe" {
  name         = "peering-america-2-europe"
  network      = google_compute_network.us-vpc-tf.self_link 
  peer_network = google_compute_network.europe-vpc-tf.self_link
}

resource "google_compute_network_peering" "peering-europe-2-america" {
  name         = "peering-europe-2-america" 
  network      = google_compute_network.europe-vpc-tf.self_link
  peer_network = google_compute_network.us-vpc-tf.self_link 
}   