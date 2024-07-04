resource "aws_instance" "module-ec2" {
  ami                         = var.ami
  instance_type               = var.instance
  subnet_id                   = var.subnet_id
  vpc_security_group_ids = [var.security_group]
  iam_instance_profile        = var.iam_profile
  key_name                    = var.ssh-key
  associate_public_ip_address = var.associate_public_ip
    tags = {
    Name = "ProjectServerInstance"
  }
}

output "public_ip" {
  value = aws_instance.module-ec2.public_ip
}
