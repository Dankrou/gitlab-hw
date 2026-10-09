terraform {
  required_version = ">= 1.5.0, < 2.0.0"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.162"
    }
  }
}

# Credentials and cloud/folder IDs come from YC_* environment variables.
provider "yandex" {
  zone = var.zone
}
