resource google_compute_subnetwork us-subnet-1-tf {
  name          = "us-subnet-1-tf"
  region        = "us-east1"
  network       = google_compute_network.us-vpc-tf.id
  ip_cidr_range = "172.16.1.0/24"


  }

  resource google_compute_subnetwork us-subnet-2-tf {
  name          = "us-subnet-2-tf"
  region        = "us-central1"
  network       = google_compute_network.us-vpc-tf.id
  ip_cidr_range = "172.16.2.0/24"


  }

  resource google_compute_subnetwork asia-subnet-tf {
  name          = "asia-subnet-tf"
  region        = "asia-southeast1"
  network       = google_compute_network.asia-vpc-tf.id
  ip_cidr_range = "192.168.1.0/24"


  }

  resource google_compute_subnetwork europe-subnet-tf {
  name          = "europe-subnet-tf"
  region        = "europe-west1"
  network       = google_compute_network.europe-vpc-tf.id
  ip_cidr_range = "10.187.1.0/24"


  }