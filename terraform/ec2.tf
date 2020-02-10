resource "aws_instance" "web" {
  ami                  = "ami-011facbea5ec0363b"
  instance_type        = "t2.micro"
  subnet_id            = aws_subnet.public.id
  iam_instance_profile = aws_iam_instance_profile.ec2.name

  tags = {
    Name = var.tag
  }
}

resource "aws_iam_role" "ec2_role" {
  name               = "SSMInstanceProfile"
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

resource "aws_iam_policy" "ec2_role" {
  name   = "ssm_instance_profile_policy"
  policy = templatefile("ec2-role-policy.tpl", {})
}

resource "aws_iam_role_policy_attachment" "ec2_role" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.ec2_role.arn
}

resource "aws_iam_instance_profile" "ec2" {
  name = "ec2-profile"
  role = aws_iam_role.ec2_role.name
}
