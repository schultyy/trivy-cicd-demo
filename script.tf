provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "vulnerable_instance" {
  ami           = "ami-12345678" # Outdated AMI with known vulnerabilities
  instance_type = "t2.micro"

  tags = {
    Name = "VulnerableInstance"
  }
}

resource "aws_security_group" "vulnerable_sg" {
  name        = "vulnerable_sg"
  description = "Allow all inbound traffic"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_s3_bucket" "vulnerable_bucket" {
  bucket = "my-vulnerable-bucket"
  acl    = "public-read" # Publicly accessible

  versioning {
    enabled = false
  }
}

resource "aws_db_instance" "vulnerable_db_instance" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t2.micro"
  db_name              = "mydb"
  username             = "user"
  password             = "password" # Hardcoded secret
  parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true
}
