resource "aws_iam_role" "ssm_role_ec2" {
  name = "MBRoleForEC2"
  assume_role_policy = <<EOF
{
    "Version" : "2012-10-17",
    "Statement" : [
        {
            "Effect" : "Allow",
            "Principal": {
                "Service" : "ec2.amazonaws.com"
            },
            "Action" : "sts:AssumeRole"
        }
    ]
}
EOF
}

resource "aws_iam_instance_profile" "ssm_ec2_instance_profile" {
  depends_on = [ aws_iam_role.ssm_role_ec2 ]
 name = "MBSSMEC2InstanceProfile"
 role = aws_iam_role.ssm_role_ec2.name 
}

resource "aws_iam_role_policy_attachment" "iam_role_attachment" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  ])

  role = aws_iam_role.ssm_role_ec2.name
  policy_arn = each.value
}