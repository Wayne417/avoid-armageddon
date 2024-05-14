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