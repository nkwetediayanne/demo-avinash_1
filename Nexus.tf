resource "aws_instance" "Nexus_instance" {
  ami         ="ami-0aeeebd8d2ab47354"
instance_type ="t2.medium"
associate_public_ip_address = true
key_name = "CICD-PIPE-LINE"
vpc_security_group_ids = [aws_security_group.KINGDON_CICD_SG.name]
user_data = <<EOF
#!/bin/bash
sudo su
yum upgrade -y
yum install wget -y
yum install java-1.8.0-openjdk.x86_64 -y
mkdir /app && cd /app
sudo wget -O nexus.tar.gz https://download.sonatype.com/nexus/3/latest-unix.tar.gz
tar -xvf nexus.tar.gz
mv nexus-3* nexus
adduser nexus
sudo chown -R nexus:nexus /app/nexus
sudo chown -R nexus:nexus /app/sonatype-work
sed -i 's/""/"nexus"/gi' /app/nexus/bin/nexus.rc
cat >/etc/systemd/system/nexus.service <<EOL
[Unit]
Description=nexus service
After=network.target
[Service]
Type=forking
LimitNOFILE=65536
User=nexus
Group=nexus
ExecStart=/app/nexus/bin/nexus start
ExecStop=/app/nexus/bin/nexus stop
User=nexus
Restart=on-abort
[Install]
WantedBy=multi-user.target
EOL
chkconfig nexus on
sudo systemctl start nexus
EOF
tags = {
  Name = "Nexus"
}
}
output "Nexus_IP" {
  value       = aws_instance.Nexus_instance.public_ip
}
