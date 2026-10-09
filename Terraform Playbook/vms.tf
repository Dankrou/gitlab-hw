data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2204-lts"
}

resource "yandex_compute_instance" "web" {
  count = 2

  name        = ["web-a", "web-b"][count.index]
  hostname    = ["web-a", "web-b"][count.index]
  platform_id = "standard-v3"
  zone        = var.zone

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
      type     = "network-hdd"
      size     = 10
    }
  }

  scheduling_policy {
    preemptible = var.preemptible
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.web.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.web.id]
  }

  metadata = {
    user-data = templatefile("${path.module}/cloud-init.yml.tftpl", {
      ssh_public_key = jsonencode(trimspace(file(pathexpand(var.ssh_public_key_file))))
    })
  }
}
