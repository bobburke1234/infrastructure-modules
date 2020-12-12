provider "aws" {
    region = var.region
}
data "aws_ami" "ami" {
  owners           = ["amazon"]
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}
resource "aws_instance" "myec2" {
    ami = data.aws_ami.ami.id
    instance_type = var.instance_type
    count = var.instance_count
}