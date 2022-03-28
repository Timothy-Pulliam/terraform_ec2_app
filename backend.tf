terraform {
  backend "s3" {
    # state file location
    bucket = "logicloud-terraform-state"
    key    = "project1/terraform.tfstate"
    region = "us-east-1"

    # dynamoDB state locking
    dynamodb_table = "tfm-state-lock"
  }
}