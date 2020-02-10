locals {
  port = 3306
}

resource "aws_security_group" "db" {
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = local.port
    to_port     = local.port
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }

  tags = {
    Name = "${var.tag}-db"
  }
}

resource "aws_db_subnet_group" "main" {
  subnet_ids = [
    for subnet in aws_subnet.private:
    subnet.id
  ]

  tags = {
    Name = var.tag
  }
}

resource "aws_db_instance" "main" {
  identifier            = "ssm-db"
  engine                = "mysql"
  engine_version        = "5.7.22"
  instance_class        = "db.t3.micro"
  allocated_storage     = 20
  max_allocated_storage = 100
  storage_type          = "gp2"
  db_subnet_group_name  = aws_db_subnet_group.main.name
  multi_az              = false

  username               = "ssm_user"
  password               = "foobarbaz"
  port                   = local.port
  publicly_accessible    = false
  vpc_security_group_ids = [aws_security_group.db.id]

  skip_final_snapshot       = true
  deletion_protection       = false

  tags = {
    Name = var.tag
  }
}
