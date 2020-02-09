resource "aws_instance" "web" {
  ami           = "ami-011facbea5ec0363b"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public.id

  tags = {
    Name = var.tag
  }
}

