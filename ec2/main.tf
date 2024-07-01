provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "app_server" {
  ami                    = var.ami_id
  instance_type          = var.instance
  iam_instance_profile   = var.iam_instance_profile
  key_name               = var.key_name
  count                  = var.instance_count
  vpc_security_group_ids = [aws_security_group.network_security_group.id]
  subnet_id              = var.subnet_id
  user_data              = var.user_data

  tags = {
    Name = "ProjectServerInstance ${count.index + 1}"
  }
}

resource "null_resource" "ansible" {
  depends_on = [aws_instance.app_server]

  provisioner "local-exec" {
    command = <<EOT
      sleep 30
      echo "[ec2]" > ec2-ansible/inventory.ini
      echo "${aws_instance.app_server[0].public_ip} ansible_ssh_private_key_file=/Users/snehatuladhar/Documents/cloudintern/amisneha.pem ansible_user=ec2-user" >> ec2-ansible/inventory.ini
      ansible-playbook -i ec2-ansible/inventory.ini /Users/snehatuladhar/Documents/cloudintern/modules/ec2/playbook.yml -u ec2-user --private-key /Users/snehatuladhar/Documents/cloudintern/amisneha.pem --ssh-extra-args='-o StrictHostKeyChecking=no' -v
    EOT
  }
}

resource "aws_security_group" "network_security_group" {
  name        = var.network_security_group_name
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "SSM"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "nsg-inbound"
  }
}
