variable "network_security_group_name" {
  description = "The name of the network security group."
  type        = string
}

variable "instance" {
  description = "The instance type to use."
  type        = string
}

variable "instance_count" {
  description = "The number of instances to create."
  type        = number
  default     = 1
}

variable "ami_id" {
  description = "The AMI ID to use for the instance."
  type        = string
}

variable "subnet_id" {
  description = "The subnet ID to launch the instance in."
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID to launch the instance in."
  type        = string
}

variable "iam_instance_profile" {
  description = "The IAM instance profile to attach to the instance."
  type        = string
}

variable "user_data" {
  description = "The user data script to use for the instance."
  type        = string
}

variable "key_name" {
  description = "The name of the SSH key pair to use for the instance."
  type        = string
}
