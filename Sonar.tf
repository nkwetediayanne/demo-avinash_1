resource "aws_instance" "Sonar_instance" {
  ami           ="ami-0aeeebd8d2ab47354"
instance_type ="t2.medium"
associate_public_ip_address = true
key_name = "CICD-PIPE-LINE"
vpc_security_group_ids = [aws_security_group.KINGDON_CICD_SG.name]
user_data = <<EOF
#!/bin/bash
sudo su
yum upgrade -y
yum update -y
yum install java-1.8.0 -y
sudo wget -O /etc/yum.repos.d/sonar.repo http://downloads.sourceforge.net/project/sonar-pkg/rpm/sonar.repo
yum install sonar -y
service sonar start
EOF
tags = {
  Name = "Sonar-Qube"
}
}
output "Sonar_IP" {
  value       = aws_instance.Sonar_instance.public_ip
}
