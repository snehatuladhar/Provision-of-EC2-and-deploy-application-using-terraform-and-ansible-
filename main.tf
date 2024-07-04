module "ec2" {
  source = "./ec2"
  ami                         = var.ami
  instance_type               = var.instance
  subnet_id                   = var.subnet_id
  vpc_security_group_ids = [var.security_group]
  iam_instance_profile        = var.iam_profile
  key_name                    = var.ssh-key
  associate_public_ip_address = var.associate_public_ip
  
}

resource "null_resource" "ansible" {
  depends_on = [module.ec2]
  provisioner "local-exec" {
    command = <<EOT
    ansible-playbook -i Ansible/aws_ec2.yml Ansible/playbook.yml -v
  EOT
  }
}


