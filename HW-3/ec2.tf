data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}
data "aws_ami" "amazon" {
  most_recent = true
  owners      = ["137112412989"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
resource "aws_instance" "Ubunty" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public1.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  associate_public_ip_address = true
  user_data = <<-EOF
              #!/bin/bash
              apt update
              apt install -y apache2
              echo 'Hello, World!' > /var/www/html/index.html
              systemctl start apache2
              systemctl enable apache2
            EOF
  tags = {
    Name = "Ubunty"
  }
}
resource "aws_instance" "Amazon" {
  ami                    = data.aws_ami.amazon.id
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.public2.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]
  associate_public_ip_address = true
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              echo 'Hello, World!' > /var/www/html/index.html
              systemctl start httpd
              systemctl enable httpd
            EOF
  tags = {
    Name = "Amazon"
  }
}