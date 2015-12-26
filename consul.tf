#
# Consul configuration
#

provider "google" {
  project = "${var.project}"
  region = "${var.region}"
  credentials = "${var.credentials}"
  account_file = "${var.credentials}"
}

resource "google_compute_instance" "consul" {
  count = "${var.servers}"
  zone = "${var.zone}"
  name = "terraform-consul-${count.index}"
  tags = [ "${var.tagName}", "master" ]

  description = "terraform consul server"
  machine_type = "${var.instance_type}"
  can_ip_forward = false

  # Create a new boot disk from an image
  disk {
    image = "${lookup(var.ami, concat(var.region, "-", var.platform))}"
    auto_delete = true
    type = "pd-standard"
  }

  network_interface {
    network = "${var.networkName}"
    access_config {
      # ephemeral ip
    }
  }

  metadata {
    sshKeys = "${lookup(var.user, var.platform)}:${file(var.ssh_pub_path)}"
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
      "echo ${google_compute_instance.consul.0.network_interface.0.address} > /tmp/consul-server-addr",
      "echo ${var.consul_flags} > /tmp/consul-flags"
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
