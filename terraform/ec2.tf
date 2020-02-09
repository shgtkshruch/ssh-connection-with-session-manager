resource "aws_instance" "web" {
  ami                  = "ami-011facbea5ec0363b"
  instance_type        = "t2.micro"
  subnet_id            = aws_subnet.public.id
  iam_instance_profile = aws_iam_instance_profile.ec2.name

  tags = {
    Name = var.tag
  }
}

