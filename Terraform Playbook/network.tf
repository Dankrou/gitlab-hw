resource "yandex_vpc_network" "web" {
  name = "nlb-hw-network"
}

resource "yandex_vpc_subnet" "web" {
  name           = "nlb-hw-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.web.id
  v4_cidr_blocks = ["10.10.10.0/24"]
}

resource "yandex_vpc_security_group" "web" {
  name       = "nlb-hw-web-sg"
  network_id = yandex_vpc_network.web.id

  ingress {
    description    = "HTTP from clients and load balancer health checks"
    protocol       = "TCP"
    port           = 80
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description    = "SSH from the administrator's public address"
    protocol       = "TCP"
    port           = 22
    v4_cidr_blocks = [var.admin_cidr]
  }

  egress {
    description    = "Outbound access including Ubuntu package repositories"
    protocol       = "ANY"
    from_port      = 0
    to_port        = 65535
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}
