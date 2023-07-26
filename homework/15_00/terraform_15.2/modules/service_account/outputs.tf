output "access_key" {
  value = yandex_iam_service_account_static_access_key.key.access_key
}

output "secret_key" {
  value = yandex_iam_service_account_static_access_key.key.secret_key
}

output "id" {
  value = yandex_iam_service_account.account.id
}