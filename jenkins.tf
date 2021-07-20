resource "aws_instance" "Jenkins_instance" {
  ami ="ami-0aeeebd8d2ab47354"
  instance_type ="t2.medium"
  associate_public_ip_address = true
  key_name = "CICD-PIPE-LINE"
  vpc_security_group_ids = [aws_security_group.KINGDON_CICD_SG.name]
  user_data = <<EOF
#!/bin/bash
cd /home/ec2-user
sudo yum install java-1.8* -y
sudo yum install wget -y
sudo yum install git -y
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
sudo yum install jenkins -y
# Start jenkins service
sudo systemctl start jenkins
# Setup Jenkins to start at boot
sudo systemctl enable jenkins
cd /home/ec2-user
ls -hart
EOF
tags = {
        Name = "Jenkins"
    }
}
output "Jenkins_IP" {
  value       = aws_instance.Jenkins_instance.public_ip
}
