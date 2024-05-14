resource "google_compute_vpn_gateway" "europe-gateway" {
  name    = "europe-gateway"
  network = google_compute_network.europe-vpc-tf.id
  region = "europe-west1"
}

resource "google_compute_address" "europe-static-ip" {
  name = "europe-static-ip"
  region = "europe-west1"
}

resource "google_compute_forwarding_rule" "europe-fwd1" {
  name        = "europe-fwd1"
  ip_protocol = "ESP"
  ip_address  = google_compute_address.europe-static-ip.address
  target      = google_compute_vpn_gateway.europe-gateway.id
  region = "europe-west1"
}

resource "google_compute_forwarding_rule" "europe-fwd2" {
  name        = "europe-fwd2"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = google_compute_address.europe-static-ip.address
  target      = google_compute_vpn_gateway.europe-gateway.id
  region = "europe-west1"
}

resource "google_compute_forwarding_rule" "europe-fwd3" {
  name        = "europe-fwd3"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = google_compute_address.europe-static-ip.address
  target      = google_compute_vpn_gateway.europe-gateway.id
  region = "europe-west1"
}

resource "google_compute_vpn_tunnel" "europe-tunnel" {
  name          = "europe-tunnel"
  peer_ip       = google_compute_address.asia-static.address
  shared_secret = sensitive("a secret message")
  local_traffic_selector = ["10.187.1.0/24"]
  target_vpn_gateway = google_compute_vpn_gateway.europe-gateway.id

  depends_on = [
    google_compute_forwarding_rule.europe-fwd1,
    google_compute_forwarding_rule.europe-fwd2,
    google_compute_forwarding_rule.europe-fwd3,
  ]
}

resource "google_compute_route" "europe-route" {
  name       = "europe-route"
  network    = google_compute_network.europe-vpc-tf.name
  dest_range = "192.168.1.0/24"
  priority   = 1000

  next_hop_vpn_tunnel = google_compute_vpn_tunnel.europe-tunnel.id
  depends_on = [ google_compute_vpn_tunnel.europe-tunnel ]
}