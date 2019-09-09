resource "aws_iam_group" "admins" {
  name = "admins"
}

data "aws_iam_policy" "DatabaseAdministrator" {
  arn = "arn:aws:iam::aws:policy/job-function/DatabaseAdministrator"
}

data "aws_iam_policy" "SystemAdministrator" {
  arn = "arn:aws:iam::aws:policy/job-function/SystemAdministrator"
}
data "aws_iam_policy" "NetworkAdministrator" {
  arn = "arn:aws:iam::aws:policy/job-function/NetworkAdministrator"
}

data "aws_iam_policy" "IAMUserChangePassword" {
  arn = "arn:aws:iam::aws:policy/IAMUserChangePassword"
}


resource "aws_iam_group_policy_attachment" "admins-1-policy-attach" {
  group      = "${aws_iam_group.admins.name}"
  policy_arn = "${data.aws_iam_policy.DatabaseAdministrator.arn}"
}
resource "aws_iam_group_policy_attachment" "admins-2-policy-attach" {
  group      = "${aws_iam_group.admins.name}"
  policy_arn = "${data.aws_iam_policy.SystemAdministrator.arn}"
}
resource "aws_iam_group_policy_attachment" "admins-3-policy-attach" {
  group      = "${aws_iam_group.admins.name}"
  policy_arn = "${data.aws_iam_policy.NetworkAdministrator.arn}"
}
resource "aws_iam_group_policy_attachment" "admins-4-policy-attach" {
  group      = "${aws_iam_group.admins.name}"
  policy_arn = "${data.aws_iam_policy.IAMUserChangePassword.arn}"
}


resource "aws_iam_user" "prnx-admin" {
  name = "prnx-admin"

  tags = {
    Terraform   = "true"
    Environment = "prnx-perm"
  }
}

resource "aws_iam_user_login_profile" "prnx-admin" {
  user                    = "${aws_iam_user.prnx-admin.name}"
  password_reset_required = true
  pgp_key                 = "keybase:prnx-admin"
}

resource "aws_iam_user_group_membership" "prnx-admin" {
  user = "${aws_iam_user.prnx-admin.name}"

  groups = [
    "${aws_iam_group.admins.name}",
  ]
}
