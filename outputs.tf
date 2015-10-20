output "server_address" {
    value = "${google_compute_instance_template.server.0.network_interface.access_config.nat_ip}"
}