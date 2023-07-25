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
  source       = "./modules/vpc_network"
  zone         = var.zone
  subnet_name  = var.public_subnet_name
  subnet_cidr  = var.public_subnet_cidr
  network_id   = resource.yandex_vpc_network.network.id
}

module "network_private" {
  source         = "./modules/vpc_network"
  zone           = var.zone
  subnet_name    = var.private_subnet_name
  subnet_cidr    = var.private_subnet_cidr
  network_id     = resource.yandex_vpc_network.network.id
  route_table_id = module.route_table.route_table_id
}

module "route_table" {
  source = "./modules/vpc_route_table"
  route_table_name = "privte-to-public"
  network_id = resource.yandex_vpc_network.network.id
  ip_address = module.nat_instance.ip_address
}

module "nat_instance" {
  source          = "./modules/vm_instance"
  zone            = var.zone
  instance_name   = var.nat_instance_name
  platform_id     = var.nat_instance_platform_id
  resource_core   = var.nat_instance_core
  resource_memory = var.nat_instance_memory
  image_id        = var.nat_instance_image_id
  nat             = true
  subnet_id       = module.network_public.subnet_id
  ip_address      = var.nat_instance_ip
}

module "vm_pub_instance" {
  source          = "./modules/vm_instance"
  zone            = var.zone
  instance_name   = var.vm_pub_instance_name
  platform_id     = var.vm_pub_instance_platform_id
  resource_core   = var.vm_pub_instance_core
  resource_memory = var.vm_pub_instance_memory
  image_id        = var.vm_pub_instance_image_id
  nat             = true
  subnet_id       = module.network_public.subnet_id
}

module "vm_pri_instance" {
  source          = "./modules/vm_instance"
  zone            = var.zone
  instance_name   = var.vm_pri_instance_name
  platform_id     = var.vm_pri_instance_platform_id
  resource_core   = var.vm_pri_instance_core
  resource_memory = var.vm_pri_instance_memory
  image_id        = var.vm_pri_instance_image_id
  nat             = false
  subnet_id       = module.network_private.subnet_id
}
