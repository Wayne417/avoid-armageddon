resource google_compute_network europe-vpc-tf {
  name                    = "europe-vpc-tf"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
  mtu                     = 1460
}

resource google_compute_network asia-vpc-tf {
  name                    = "asia-vpc-tf"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
  mtu                     = 1460
}

resource google_compute_network us-vpc-tf {
  name                    = "us-vpc-tf"
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
  mtu                     = 1460
}