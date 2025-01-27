#this file consists of code for instances and sg
provider "aws" {
region = "ap-northeast-1"
access_key = ""
secret_key = ""
}

resource "aws_instance" "one" {
  ami             = "ami-030cf0a1edb8636ab"
  instance_type   = "t2.micro"
  key_name        = "sk"
  vpc_security_group_ids = [aws_security_group.three.id]
  availability_zone = "ap-northeast-1a"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
cat "<h1>Kya ukhad lige tum <h1>" > /var/www/html/index.html
echo "
EOF
  tags = {
    Name = "server-1"
  }
}

resource "aws_instance" "two" {
  ami             = "ami-030cf0a1edb8636ab"
  instance_type   = "t2.micro"
  key_name        = "sk"
  vpc_security_group_ids = [aws_security_group.three.id]
  availability_zone = "ap-northeast-1c"
  user_data       = <<EOF
#!/bin/bash
sudo -i
yum install httpd -y
systemctl start httpd
chkconfig httpd on
echo "Good morining bhai mai server 2" > /var/www/html/index.html

EOF
  tags = {
    Name = "server-2"
  }
}

resource "aws_security_group" "three" {
  name = "elb-sg"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_s3_bucket" "four" {
  bucket = "myapnortheastb"
}

resource "aws_iam_user" "five" {
name = "rahamuser11" 
}

resource "aws_ebs_volume" "six" {
 availability_zone = "ap-northeast-1c"
  size = 40
  tags = {
    Name = "ebs-001"
  }
}
