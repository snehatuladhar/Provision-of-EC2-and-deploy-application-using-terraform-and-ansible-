provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      owner     = "sneha.tuladhar@adex.ltd"
      silo      = "intern"
      terraform = "true"
    }
  }
}
