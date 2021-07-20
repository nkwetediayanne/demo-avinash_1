variable "ami_id" {
  type = map
  default = {
  Us-east-1 = "ami-0aeeebd8d2ab47354"
  Us-east-2 = "ami-0d8d212151031f51c"
  Us-west-1 = "ami-0b2ca94b5b49e0132"
}
}
variable "instance_type" {
  type = list
  default = ["t2.nano","t2.micro","t2.large","t2.medium"]
}
variable "profile" {
default =""
}
variable "region" {
  default = ""
}
