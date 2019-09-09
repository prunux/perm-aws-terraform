# Webserver
module "web_server_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "web-server-sg"
  description = "Security group for web-server with HTTP and HTTPS ports open within VPC, and SSH to prunux.ch"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_cidr_blocks      = ["0.0.0.0/0"]
  ingress_ipv6_cidr_blocks = ["::/0"]
  # HTTP and HTTPS
  ingress_rules = [
    "http-80-tcp",
    "https-443-tcp"
  ]

  # SSH
  ingress_with_cidr_blocks = [
    {
      rule        = "ssh-tcp"
      cidr_blocks = "1.2.3.4/32,2.3.4.5/32" ### REPLACEME !!!
      description = "Allow SSH access from prnx admin IPv4"
    }
  ]
  ingress_with_ipv6_cidr_blocks = [
    {
      rule             = "ssh-tcp"
      ipv6_cidr_blocks = "2001:1620:abcd:abcd:/56,2a05:d014:abcd:abcd::/64" ### REPLACEME !!!
      description      = "Allow SSH access from prnx admin IPv6"

    }
  ]

  tags = {
    Terraform   = "true"
    Environment = "prnx-perm"
  }
}

#### RDS Aurora PostgreSQL

resource "aws_security_group" "aurora_postgresql_sg" {
  name        = "aurora-postgresql-sg"
  description = "Allow PostgreSQL inbound traffic"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    description     = "allow PostgreSQL inbound traffic"
    security_groups = ["${module.web_server_sg.this_security_group_id}"]
  }

  tags = {
    Terraform   = "true"
    Environment = "prnx-perm"
    Name        = "aurora-postgresql-sg"
  }

}

