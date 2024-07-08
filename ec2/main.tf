resource "aws_instance" "app_server" {
  ami           = var.ami_id
  instance_type = var.instance
  iam_instance_profile = var.iam_instance_profile
  key_name = var.key_name
  count         = var.instance_count
  vpc_security_group_ids = [aws_security_group.network-security-group.id]
  subnet_id = var.subnet_id
  user_data = var.user_data

    provisioner "local-exec" {
    command = <<EOT
      echo "[example]" > hosts
      echo "${self.public_ip} ansible_ssh_private_key_file=/Users/snehatuladhar/Downloads/deploy-application-using-terraform-and-ansible-INTERN-747/amisneha.pem ansible_user=ec2-user" >> hosts
      ansible-playbook -i hosts /Users/snehatuladhar/Downloads/deploy-application-using-terraform-and-ansible-INTERN-747/ansible/playbook.yml --ssh-extra-args='-o StrictHostKeyChecking=no'
    EOT
    //depends on
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("/Users/snehatuladhar/Downloads/deploy-application-using-terraform-and-ansible-INTERN-747/amisneha.pem")
      host        = self.public_ip
    }
  }


  tags = {
    Name = "ProjectServerInstance ${count.index + 1}"
  }
}
# Creating a security group to restrict/allow inbound connectivity
resource "aws_security_group" "network-security-group" {
  name        = var.network_security_group_name
  description = "Allow TLS inbound traffic"
  vpc_id = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  egress{
    description ="SSM"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] 
  }
  
  tags = {
    Name = "nsg-inbound"
  }
}