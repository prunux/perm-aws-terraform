data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

module "ec2_preload_aurora" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 2.0"

  name           = "preload-aurora"
  instance_count = 0
  ami            = "${data.aws_ami.ubuntu.id}"
  instance_type  = "t2.micro"
  key_name       = "perm-ssh-key"

  vpc_security_group_ids = [
    "${module.vpc.default_security_group_id}",
    "${module.web_server_sg.this_security_group_id}",
  ]
  subnet_id                   = "${module.vpc.public_subnets[0]}"
  associate_public_ip_address = true
  ipv6_address_count          = 1

  user_data = "${file("ec2-preload-sql-user-data.sh")}"

  tags = {
    Terraform   = "true"
    Environment = "prnx-perm"
  }
}

output "ec2_preload_aurora_instance" {
  value = "${module.ec2_preload_aurora.public_dns}"
}