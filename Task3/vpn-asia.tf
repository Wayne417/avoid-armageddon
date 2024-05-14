resource "google_compute_vpn_gateway" "asia-gateway" {
  name    = "asia-gateway"
  network = google_compute_network.asia-vpc-tf.id
  region = "asia-southeast1"
}

resource "google_compute_address" "asia-static" {
  name = "asia-static"
  region = "asia-southeast1"
}

resource "google_compute_forwarding_rule" "asia-fwd1" {
  name        = "asia-fwd1"
  ip_protocol = "ESP"
  ip_address  = google_compute_address.asia-static.address
  target      = google_compute_vpn_gateway.asia-gateway.id
  region = "asia-southeast1"
}

resource "google_compute_forwarding_rule" "asia-fwd2" {
  name        = "asia-fwd2"
  ip_protocol = "UDP"
  port_range  = "500"
  ip_address  = google_compute_address.asia-static.address
  target      = google_compute_vpn_gateway.asia-gateway.id
  region = "asia-southeast1"
}

resource "google_compute_forwarding_rule" "asia-fwd3" {
  name        = "asia-fwd3"
  ip_protocol = "UDP"
  port_range  = "4500"
  ip_address  = google_compute_address.asia-static.address
  target      = google_compute_vpn_gateway.asia-gateway.id
  region = "asia-southeast1"
}

resource "google_compute_vpn_tunnel" "asia-tunnel" {
  name          = "asia-tunnel"
  peer_ip       = google_compute_address.europe-static-ip.address
  shared_secret = sensitive("a secret message")
  local_traffic_selector = ["192.168.1.0/24"]
  target_vpn_gateway = google_compute_vpn_gateway.asia-gateway.id

  depends_on = [
    google_compute_forwarding_rule.asia-fwd1,
    google_compute_forwarding_rule.asia-fwd2,
    google_compute_forwarding_rule.asia-fwd3,
  ]
}

resource "google_compute_route" "asia-route" {
  name       = "asia-route"
  network    = google_compute_network.asia-vpc-tf.name
  dest_range = "10.187.1.0/24"
  priority   = 1000

  next_hop_vpn_tunnel = google_compute_vpn_tunnel.asia-tunnel.id
  depends_on = [ google_compute_vpn_tunnel.asia-tunnel ]
}
