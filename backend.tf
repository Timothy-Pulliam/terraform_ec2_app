terraform {
  backend "s3" {
    bucket = "logicloud-terraform-state"
    key    = "project1/terraform.tfstate"
    region = "us-east-1"
  }
}