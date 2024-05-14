resource "google_compute_instance" "vm-europe" {
  name         = "vm-europe"
  machine_type = "e2-micro"
  zone         = "europe-west1-b"
  metadata = {
    startup-script = "#Thanks to Remo\n#!/bin/bash\n# Update and install Apache2\napt update\napt install -y apache2\n\n# Start and enable Apache2\nsystemctl start apache2\nsystemctl enable apache2\n\n# GCP Metadata server base URL and header\nMETADATA_URL=\"http://metadata.google.internal/computeMetadata/v1\"\nMETADATA_FLAVOR_HEADER=\"Metadata-Flavor: Google\"\n\n# Use curl to fetch instance metadata\nlocal_ipv4=$(curl -H \"$${METADATA_FLAVOR_HEADER}\" -s \"$${METADATA_URL}/instance/network-interfaces/0/ip\")\nzone=$(curl -H \"$${METADATA_FLAVOR_HEADER}\" -s \"$${METADATA_URL}/instance/zone\")\nproject_id=$(curl -H \"$${METADATA_FLAVOR_HEADER}\" -s \"$${METADATA_URL}/project/project-id\")\nnetwork_tags=$(curl -H \"$${METADATA_FLAVOR_HEADER}\" -s \"$${METADATA_URL}/instance/tags\")\n\n# Create a simple HTML page and include instance details\ncat <<EOF > /var/www/html/index.html\n<html><body>\n<h2>Welcome to your custom website.</h2>\n<h3>Created with a direct input startup script!</h3>\n<p><b>Instance Name:</b> $(hostname -f)</p>\n<p><b>Instance Private IP Address: </b> $local_ipv4</p>\n<p><b>Zone: </b> $zone</p>\n<p><b>Project ID:</b> $project_id</p>\n<p><b>Network Tags:</b> $network_tags</p>\n</body></html>\nEOF"
  }
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }
  network_interface {
    network = google_compute_network.europe-vpc-tf.id
    subnetwork = google_compute_subnetwork.europe-subnet-tf.id
    access_config {
    }
  }
  
}
resource "google_compute_instance" "vm-us1-tf" {
  name         = "vm-us1-tf"
  machine_type = "e2-micro"
  zone         = "us-east1-b"

  boot_disk {
    initialize_params {
      image = "projects/windows-cloud/global/images/windows-server-2022-dc-v20240415"
      size  = 50
      type  = "pd-balanced"
    }
  }
  network_interface {
    network = google_compute_network.us-vpc-tf.id
    subnetwork = google_compute_subnetwork.us-subnet-1-tf.id
    access_config {
    }
  }
  
}

resource "google_compute_instance" "vm-us2-tf" {
  name         = "vm-us2-tf"
  machine_type = "e2-micro"
  zone         = "us-central1-c"

  boot_disk {
    initialize_params {
      image = "projects/windows-cloud/global/images/windows-server-2022-dc-v20240415"
      size  = 50
      type  = "pd-balanced"
    }
  }
  network_interface {
    network = google_compute_network.us-vpc-tf.id
    subnetwork = google_compute_subnetwork.us-subnet-2-tf.id
    access_config {
    }
  }
  
}
resource "google_compute_instance" "vm-asia1-tf" {
  name         = "vm-asia1-tf"
  machine_type = "e2-micro"
  zone         = "asia-southeast1-a"

  boot_disk {
    initialize_params {
      image = "projects/windows-cloud/global/images/windows-server-2022-dc-v20240415"
      size  = 50
      type  = "pd-balanced"
    }
  }
  network_interface {
    network = google_compute_network.asia-vpc-tf.id
    subnetwork = google_compute_subnetwork.asia-subnet-tf.id
    access_config {
    }
  }
  
}