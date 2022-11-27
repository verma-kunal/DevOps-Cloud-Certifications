terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.44.1"
    }
  }
}

provider "google" {
  project     = "PROJECT_ID_HERE"
  region      = "us-west1"
  credentials = "terraform-gcp-369813-948662349194.json"
  zone = "us-west1-b"
}

# Setting up an instance:

resource "google_compute_instance" "vm_instance" {
  name         = "tf-instance"
  machine_type = "e2-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
      labels = {
        my_label = "value"
      }
    }
  }

  network_interface {
    network = "default"
    access_config {}
  }
 
}