variable "platform" {
  default = "ubuntu"
  description = "The OS Platform"
}

variable "user" {
  description = "Platform -> user mapping"
  default = {
    ubuntu = "ubuntu"
  }
}

variable "ssh_pub_path" {
  description = "ssh public key path"
}

variable "key_path" {
  description = "ssh private key path to use with the google instance"
}

variable "region" {
    default = "europe-west1"
    description = "The region of Google Cloud, for AMI lookups."
}

variable "zone" {
  description = "google zone to use for creation"
  default = "europe-west1-d"
}

variable "ami" {
  description = "Google Disk Image Id"
  default = {
    europe-west1-ubuntu = "ubuntu-1404-trusty-v20150909a"
  }
}

variable "networkName" {
  description = "network to use for the instances"
  default = "default"
}

variable "instance_type" {
  default = "f1-micro"
  description = "Google Cloud Instance type"
}

variable "servers" {
  default = "3"
  description = "The number of Consul servers to launch."
}

variable "tagName" {
  default = "consul"
  description = "Name tag for the servers"
}

variable "consul_flags" {
  default = ""
  description = "extra configuration for consul"
}
