terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

resource "yandex_compute_instance_group" "ig" {
  name               = var.instance_group_name
  service_account_id = var.sa_id
  instance_template {
  
    platform_id = var.platform_id
    
    resources {
      cores  = var.resource_core
      memory = var.resource_memory
    }

    boot_disk {
      initialize_params {
        image_id = var.image_id
      }
    }

    network_interface {
      subnet_ids = [var.subnet_id]
      nat        = var.nat
    }

    metadata = {
      ssh-keys  = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
      user-data = var.user_data
    }

    labels = {
      group = "nlb"
    }

    scheduling_policy {
      preemptible = true
    }
  }

  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = [var.zone]
  }

  deploy_policy {
    max_unavailable = 2
    max_expansion   = 1
  }

  health_check {
    interval            = 2
    timeout             = 1
    healthy_threshold   = 5
    unhealthy_threshold = 2
    http_options {
      path = "/"
      port = 80
    }
  }

  load_balancer {
    target_group_name = "tg-nginx"
  }
}