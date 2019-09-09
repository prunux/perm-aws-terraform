module "rds_cluster_aurora_postgresql_serverless" {
  source         = "git::https://github.com/cloudposse/terraform-aws-rds-cluster.git?ref=master"
  namespace      = "prnx-perm"
  stage          = "prod"
  name           = ""
  engine         = "aurora-postgresql"
  engine_mode    = "serverless"
  cluster_family = "aurora-postgresql10"
  cluster_size   = "0"
  admin_user     = "prnx_dbadmin"
  admin_password = "ug7cae7RahlahRoe6Aefeata"
  db_name        = "perm"
  db_port        = "5432"
  vpc_id         = "${module.vpc.vpc_id}"
  security_groups = [
    "${module.web_server_sg.this_security_group_id}",
    "${aws_security_group.aurora_postgresql_sg.id}"
  ]
  subnets = "${module.vpc.database_subnets}"
  #zone_id         = "Zxxxxxxxx"
  retention_period = 10

  scaling_configuration = [
    {
      auto_pause               = true
      max_capacity             = 4
      min_capacity             = 2
      seconds_until_auto_pause = 300
    }
  ]

  tags = {
    Terraform   = "true"
    Environment = "prnx-perm"
  }
}

# create IAM role for monitoring
resource "aws_iam_role" "enhanced_monitoring" {
  name               = "rds-cluster-prnx-perm"
  assume_role_policy = data.aws_iam_policy_document.enhanced_monitoring.json
}

# Attach Amazon's managed policy for RDS enhanced monitoring
resource "aws_iam_role_policy_attachment" "enhanced_monitoring" {
  role       = aws_iam_role.enhanced_monitoring.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}

# allow rds to assume this role
data "aws_iam_policy_document" "enhanced_monitoring" {
  statement {
    actions = [
      "sts:AssumeRole",
    ]

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["monitoring.rds.amazonaws.com"]
    }
  }
}
