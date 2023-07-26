terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

resource "yandex_vpc_route_table" "route" {
  name       = var.route_table_name
  network_id = var.network_id

  static_route {
    destination_prefix = "0.0.0.0/0"
    next_hop_address   = var.ip_address
  }
}