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
}