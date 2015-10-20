#
# Consul configuration
#

resource "google_compute_instance_template" "server" {

  name = "terraform-consul"
  description = "terraform consul server template"
  instance_description = "terraform consul master server"
  machine_type = "${var.instance_type}"
  can_ip_forward = false
  automatic_restart = true
  on_host_maintenance = "MIGRATE"
  tags = [ "${var.tagName}", "master" ]

  # Create a new boot disk from an image
  disk {
    source_image = "${lookup(var.ami, concat(var.region, "-", var.platform))}"
    auto_delete = true
    boot = true
  }

  network_interface {
    network = "${var.networkName}"
    access_config {
      # ephemeral ip
    }
  }

  metadata {
    sshKeys = "${var.ssh_pub_keys}"
  }

  connection {
    user = "${lookup(var.user, var.platform)}"
    key_file = "${var.key_path}"
  }

  provisioner "file" {
    source = "${path.module}/scripts/${var.platform}/upstart.conf"
    destination = "/tmp/upstart.conf"
  }

  provisioner "file" {
    source = "${path.module}/scripts/${var.platform}/upstart-join.conf"
    destination = "/tmp/upstart-join.conf"
  }

  provisioner "remote-exec" {
    inline = [
      "echo ${var.servers} > /tmp/consul-server-count",
      "echo ${google_compute_instance_template.server.0.network_interface.access_config.nat_ip} > /tmp/consul-server-addr",
    ]
  }

  provisioner "remote-exec" {
    scripts = [
      "${path.module}/scripts/${var.platform}/install.sh",
      "${path.module}/scripts/${var.platform}/server.sh",
      "${path.module}/scripts/${var.platform}/service.sh",
    ]
  }

}

resource "google_compute_instance_group_manager" "server" {
  description = "Terraform consul instance group manager"
  name = "terraform-consul"
  instance_template = "${google_compute_instance_template.server.self_link}"
  target_pools = [ "${google_compute_target_pool.server.self_link}" ]
  base_instance_name = "consul"
  zone = "${var.servers}"
  target_size = "${var.zone}"
}
