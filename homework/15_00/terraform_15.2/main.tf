terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  zone = var.zone
}

resource "yandex_vpc_network" "network" {
  name = var.network_name
}

module "network_public" {
  source      = "./modules/vpc_network"
  zone        = var.zone
  subnet_name = var.public_subnet_name
  subnet_cidr = var.public_subnet_cidr
  network_id  = resource.yandex_vpc_network.network.id
}

module "sa_s3" {
  source    = "./modules/service_account"
  sa_name   = "s3admin"
  sa_role   = "storage.editor"
  folder_id = var.folder_id
}

module "sa_vmg" {
  source    = "./modules/service_account"
  sa_name   = "vmgadmin"
  sa_role   = "editor"
  folder_id = var.folder_id
}

module "s3_bucket" {
  source      = "./modules/s3_bucket"
  sa_name     = "s3admin"
  bucket_name = "bucket-netology"
  image_name  = "test.png"
  image_path  = "./files/test.png"
  access_key  = module.sa_s3.access_key
  secret_key  = module.sa_s3.secret_key
}

module "vm_instance_group" {
  source              = "./modules/vm_instance_group"
  zone                = var.zone
  instance_group_name = var.vm_instance_group_name
  platform_id         = var.vm_instance_platform_id
  resource_core       = var.vm_instance_core
  resource_memory     = var.vm_instance_memory
  image_id            = var.vm_instance_image_id
  nat                 = true
  subnet_id           = module.network_public.subnet_id
  sa_id               = module.sa_vmg.id
  user_data           = "#!/bin/bash\n cd /var/www/html\n echo \"<html><h1>NLB web-server</h1><img src='https://${module.s3_bucket.bucket_dn}/${module.s3_bucket.bucket_upload}'></html>\" > index.html"
}

module "nlb" {
  source = "./modules/nlb"
  nlb_name = "nlb"
  tg_id = module.vm_instance_group.tg_id
}