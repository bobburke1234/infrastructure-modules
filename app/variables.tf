variable "instance_type" {
    type = string
    default = "t2.micro"
}
variable "region" {
    type = string
    default = "us-east-2"
}
variable "instance_count" {
    type = number
    default = 1
}