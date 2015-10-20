# Google cloud consul terraform module

## Module Input Variables

1. `platform` - for now just `ubuntu`
2. `user` - for now just `ubuntu`
3. `region` - defaults to `europe-west1`
4. `zone` - defaults to `europe-west1-d`
5. `ami` - `europe-west1-ubuntu = "ubuntu-1404-trusty-v20150909a"`
6. `networkName` - "default"
7. `ssh_pub_path` - path to public rsa file
8. `key_path` - path to private rsa file
9. `instance_type` - `f1-micro`
10. `servers` - 3 by default
11. `tagName` - "consul"
12. `consul_flags` - optional, defaults to ""

## Usage

```tf
module "consul" {
  source = "github.com/makeomatic/tf_google_consul"
  servers = 3
  key_path = "~/.ssh/google_compute_engine"
  ssh_pub_path = "~/.ssh/google_compute_engine.pub"
  consul_flags = "-atlas USERNAME/PROJECT -atlas-token ${var.atlas_token}"
}
```

consul_flags is an optional variable

## Outputs

1. `server_address` - internal address
2. `external_address` - external address

## Authors

Originally created and maintained by [Vitaly Aminev](https://github.com/avvs)

## License

ISC Licensed. See LICENSE for full details.
