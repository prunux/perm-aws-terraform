###
# create your own AMI as described here:
#   https://gitlab.com/prunux/perm/blob/master/INSTALL
#
# or ask contact@prunux.ch for getting permission of this
# manufactored AMI on AWS eu-west-1
###

data "aws_ami" "ubuntu_bionic_perm_gedafe" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu-18.04-perm-gedafe-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["011681443068"] #
}

module "ec2_perm" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name           = "perm"
  instance_count = 1
  ami            = "${data.aws_ami.ubuntu_bionic_perm_gedafe.id}"
  instance_type  = "t2.micro"
  key_name       = "perm-ssh-key"

  vpc_security_group_ids = [
    "${module.vpc.default_security_group_id}",
    "${module.web_server_sg.this_security_group_id}",
  ]
  subnet_id                   = "${module.vpc.public_subnets[0]}"
  associate_public_ip_address = true
  ipv6_address_count          = 1

  user_data = "${file("ec2-perm-user-data.sh")}"

  tags = {
    Terraform   = "true"
    Environment = "prnx-perm"
  }
}

output "ec2_perm_instance" {
  value = "${module.ec2_perm.public_dns}"
}