output "bucket_dn" {
  value = yandex_storage_bucket.bucket.bucket_domain_name
}

output "bucket_upload" {
  value = yandex_storage_object.upload.key
}