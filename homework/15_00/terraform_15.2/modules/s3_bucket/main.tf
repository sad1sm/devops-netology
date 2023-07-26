terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

resource "yandex_kms_symmetric_key" "key" {
  name              = "bucket-key"
  default_algorithm = "AES_256"
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

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        kms_master_key_id = yandex_kms_symmetric_key.key.id
        sse_algorithm     = "aws:kms"
      }
    }
  }
}

resource "yandex_storage_object" "upload" {
  access_key = var.access_key
  secret_key = var.secret_key
  bucket     = yandex_storage_bucket.bucket.id
  key        = var.image_name
  source     = var.image_path
}