output "server_address" {
  value = "${google_compute_instance.consul.0.network_interface.0.address}"
}

output "external_address" {
  value = "${google_compute_instance.consul.0.network_interface.0.access_config.0.nat_ip}"
}
