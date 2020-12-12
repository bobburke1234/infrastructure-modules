output "ami" {
    value = [aws_instance.myec2.ami, aws_instance.myec2.instance_type]
}