terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

resource "yandex_iam_service_account" "account" {
  name = var.sa_name
}

resource "yandex_resourcemanager_folder_iam_member" "role" {
  role      = var.sa_role
  folder_id = var.folder_id
  member    = "serviceAccount:${yandex_iam_service_account.account.id}"
}

resource "yandex_iam_service_account_static_access_key" "key" {
  service_account_id = yandex_iam_service_account.account.id
}