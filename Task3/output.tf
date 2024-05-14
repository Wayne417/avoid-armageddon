/* output "vpc_name" {
  value = google_compute_network.home-work-3-tf.name
}
output "public_IP" {
  value = google_compute_subnetwork.hw2-3-subnet.gateway_address
}
output "website_url" {
  value = "http://${google_compute_instance.vm-hw2-3.network_interface.0.access_config.0.nat_ip}"
}
output "internal_ip" {
  value = google_compute_instance.vm-hw2-3.network_interface.0.network_ip
}
output "vm_subnet" {
  value = google_compute_subnetwork.hw2-3-subnet.ip_cidr_range
} */