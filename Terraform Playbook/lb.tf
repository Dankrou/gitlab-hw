resource "yandex_lb_target_group" "web" {
  name      = "nlb-hw-target-group"
  region_id = "ru-central1"

  target {
    subnet_id = yandex_vpc_subnet.web.id
    address   = yandex_compute_instance.web[0].network_interface[0].ip_address
  }

  target {
    subnet_id = yandex_vpc_subnet.web.id
    address   = yandex_compute_instance.web[1].network_interface[0].ip_address
  }
}

resource "yandex_lb_network_load_balancer" "web" {
  name = "nlb-hw-load-balancer"
  type = "external"

  listener {
    name        = "http-listener"
    port        = 80
    target_port = 80
    protocol    = "tcp"

    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.web.id

    healthcheck {
      name                = "http-healthcheck"
      interval            = 5
      timeout             = 2
      healthy_threshold   = 2
      unhealthy_threshold = 2

      http_options {
        port = 80
        path = "/"
      }
    }
  }
}
