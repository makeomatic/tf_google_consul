variable "platform" {
  default = "ubuntu"
  description = "The OS Platform"
}

variable "user" {
  default = {
    ubuntu = "ubuntu"
  }
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

variable "ssh_pub_keys" {
  description "ssh public key to associate with the instance, format of keyname:ssh-rsa ...\n and so on"
}

variable "key_path" {
  description "ssh private key path to use with the google instance"
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
