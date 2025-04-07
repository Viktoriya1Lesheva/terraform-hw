resource "aws_instance" "web" {
  count                     = 3
  ami                       = "ami-0323f519eb8aae9de"
  instance_type             = "t2.micro"
  availability_zone         = ["us-west-2a", "us-west-2b", "us-west-2c"][count.index]
  key_name                  = aws_key_pair.deployer.key_name
  vpc_security_group_ids    = [aws_security_group.web_sg.id]
  associate_public_ip_address = true
  user_data = file("${path.module}/apache.sh")
  tags = {
    Name = "web-${count.index + 1}"
  }
}