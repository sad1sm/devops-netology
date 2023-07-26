terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

resource "random_string" "random" {
  length  = 16
  special = false
  upper   = false
}

resource "yandex_storage_bucket" "bucket" {
  access_key = var.access_key
  secret_key = var.secret_key
  bucket     = "${var.bucket_name}-${random_string.random.result}"

  max_size = 1073741824

  anonymous_access_flags {
    read = true
    list = false
  }
}

resource "yandex_storage_object" "upload" {
  access_key = var.access_key
  secret_key = var.secret_key
  bucket     = yandex_storage_bucket.bucket.id
  key        = var.image_name
  source     = var.image_path
}