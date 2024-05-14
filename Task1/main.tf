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
 

resource "google_storage_bucket" "bucket_1" {
  name          = "late-night-2"

  location      = "us-east1"
  force_destroy = true
  uniform_bucket_level_access = true

  lifecycle_rule {
    condition {
      age = 30
    }
    action {
      type = "Delete"
    }
  }

  lifecycle_rule {
    condition {
      age = 30
    }
    action {
      type = "AbortIncompleteMultipartUpload"
    }
  }
  
}

resource "google_storage_bucket_iam_binding" "binding" {
  bucket = google_storage_bucket.bucket_1.name
  role = "roles/storage.admin"
  members = [
    "allUsers", 
  ]
}

resource "google_storage_bucket_object" "index" {
  name   = "index.html"
  source = "index.html"
  bucket = google_storage_bucket.bucket_1.name
}

resource "google_storage_bucket_object" "photo" {
  name   = "Beach_Babe.webp"
  source = "Beach_Babe.webp"
  bucket = google_storage_bucket.bucket_1.name
}

