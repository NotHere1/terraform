resource "aws_iam_role" "role" {
    name = "${var.owner}-${var.env}-postgres-iam-role"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "profile" {
    name = "${var.owner}-${var.env}-ec2read-only-iam-instance-profile"
    role = "${aws_iam_role.role.name}"
}

resource "aws_iam_role_policy" "policy" {
    name = "${var.owner}-${var.env}-ec2-read-only-iam-policy"
    role = "${aws_iam_role.role.name}"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:*",
      "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": "ec2:Describe*",
      "Resource": "*"
    }
  ]
}
EOF
}
