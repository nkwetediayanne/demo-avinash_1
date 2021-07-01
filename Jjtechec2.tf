locals {
  common-tags ={
  Name = "jjtech"
    App_Name = "ovid"
    Cost_center = "xyz222"
    Business_unit = "GBS"
    Project = "GBS"
    App_role = "web server"
    Customer = "students"
    Environment = "dev"
    Confidentiality = "Restricted"
    Owner = "jespo_mbwoge@jjtechinc.co"
    Opt_in-Opt_out = "Yes"
    Application_ID = "197702"
    Compliance = "pci"}
}

resource "aws_instance" "diayanneweb" {
  ami = var.ami_id["Us-east-1"]
  availability_zone = "us-east-1a"
  instance_type =var.instance_type[0]
  tags = local.common-tags
}
resource "aws_instance" "diayanneweb1" {
  ami = var.ami_id["Us-east-2"]
  availability_zone = "us-east-2a"
  instance_type = var.instance_type[1]
  tags = local.common-tags
}
output "diayanneEC2" {
   value =aws_instance.diayanneweb.public_ip
}
resource "aws_eip" "diayanneEIP" {
  vpc      = true
  tags = local.common-tags
}
output "diayanneEIP" {
   value =aws_eip.diayanneEIP.id
}
resource "aws_eip_association" "diayanneweb" {
  instance_id   = aws_instance.diayanneweb.id
  allocation_id = aws_eip.diayanneEIP.id
}

resource "aws_eip_association" "diayanneweb1" {
  instance_id   = aws_instance.diayanneweb1.id
  allocation_id = aws_eip.diayanneEIP.id
}
resource "aws_ebs_volume" "diayanneEDS" {
  availability_zone = "us-east-2a"
  size              = 40
  tags = local.common-tags
}
resource "aws_volume_attachment" "diayanneEDS-attachmet1" {
  device_name = "/dev/xvdd"
  volume_id   = aws_ebs_volume.diayanneEDS.id
  instance_id = aws_instance.diayanneweb.id
}
resource "aws_volume_attachment" "diayanneEDS-attachmet2" {
  device_name = "/dev/xvdc"
  volume_id   = aws_ebs_volume.diayanneEDS.id
  instance_id = aws_instance.diayanneweb1.id
}
