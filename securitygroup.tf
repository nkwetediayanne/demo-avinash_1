resource "aws_security_group" "KINGDON_CICD_SG" {
  name        = "KINGDON_CICD_SG"
  description = "Open All Ports"
  ingress {
    description      = "Alow_ALL"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "Allow All Traffic"
  }
}
