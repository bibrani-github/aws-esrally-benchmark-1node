output "public_ip" {
  #value = aws_instance.this.public_ip
  value = [for instance in aws_instance.this : instance.public_ip]
}
