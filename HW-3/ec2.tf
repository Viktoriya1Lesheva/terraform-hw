resource "aws_instance" "Ubunty" {
  ami           = "ami-075686beab831bb7f"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public1.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]

    user_data = <<-EOF
  #!/bin/bash
  apt update -y
  apt install apache2 -y
  EOF

  tags = {
    Name = "Ubunty"
  }
}

resource "aws_instance" "Amazon" {
  ami           = "ami-087f352c165340ea1"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.public2.id
  vpc_security_group_ids = [aws_security_group.web_sg.id]

    user_data = <<-EOF
  #!/bin/bash
  yum update -y
  yum install httpd -y
  systemctl start httpd
  systemctl enable httpd
  EOF

  tags = {
    Name = "Amazon"
  }
}