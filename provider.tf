provider "google" {
  project = "<project-id>"
  region  = "us-central1"
}

terraform {
    required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
}
