variable "ami" {
  description = "EC2 AMI"
  type        = string
}

variable "instance" {
  description = "Instance type of the EC2 instance"
  type        = string
}


variable "subnet_id" {
  description = "Subnet ID of the subnet where our instance will be created"
  type        = string
}

variable "ssh-key" {
  description = "Key to SSH into the EC2"
  type        = string
}

variable "associate_public_ip" {
  description = "To give public IP to the instance or not"
  type        = bool
  default     = false
}


variable "iam_profile" {
  description = "IAM Role Name to attach to the EC2 to allow SSM"
  type        = string
}


variable "security_group" {
  description = "SG ID"
  type = string
}
