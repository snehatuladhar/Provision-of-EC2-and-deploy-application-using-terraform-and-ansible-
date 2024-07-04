terraform {
  backend "s3" {
    bucket = "8586-terraform-state"
    key    = "sneha/sneha-tfstate"
    region = "us-east-1"
  }
}
