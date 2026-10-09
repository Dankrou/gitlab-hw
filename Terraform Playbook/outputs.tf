output "web_servers" {
  description = "VM names, internal addresses and public addresses for SSH."
  value = {
    for vm in yandex_compute_instance.web : vm.name => {
      internal_ip = vm.network_interface[0].ip_address
      public_ip   = vm.network_interface[0].nat_ip_address
    }
  }
}

output "load_balancer_ip" {
  description = "Public IPv4 address of the load balancer."
  value       = one(one(yandex_lb_network_load_balancer.web.listener).external_address_spec).address
}

output "load_balancer_url" {
  description = "Open this URL to see the default Nginx page."
  value       = "http://${one(one(yandex_lb_network_load_balancer.web.listener).external_address_spec).address}"
}

output "load_balancer_id" {
  value = yandex_lb_network_load_balancer.web.id
}

output "target_group_id" {
  value = yandex_lb_target_group.web.id
}
