resource "aws_iam_group" "ssm" {
  name = "SSMUserGroup"
}

resource "aws_iam_policy" "ssm" {
  name   = "AmazonSSMFullAccess"
  policy = templatefile("group-policy.tpl", {})
}

resource "aws_iam_group_policy_attachment" "attach" {
  group      = aws_iam_group.ssm.name
  policy_arn = aws_iam_policy.ssm.arn
}

resource "aws_iam_user" "ssm_user_1" {
  name = "ssm-user-1"

  tags = {
    Name = var.tag
  }
}

resource "aws_iam_group_membership" "ssm" {
  name = "session manager group"

  users = [
    aws_iam_user.ssm_user_1.name
  ]

  group = aws_iam_group.ssm.name
}

resource "aws_iam_access_key" "ssm_user_1" {
  user = aws_iam_user.ssm_user_1.name
}
