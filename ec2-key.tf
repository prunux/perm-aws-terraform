
module "keypair" {
  name   = "perm-ssh-key"
  source = "mitchellh/dynamic-keys/aws"
  path   = "${path.root}/keys"
}

# output "private_key_pem" {
#  value = "${module.keypair.private_key_pem}"
# }