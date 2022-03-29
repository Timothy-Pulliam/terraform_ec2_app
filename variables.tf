variable "region" {
  description = "AWS region to use"
  type = string
  default = "us-east-1"
}

variable "access_key" {
  description = "Access key for programmatic/CLI access"
  type = string
}

variable "secret_key" {
  description = "Access key secret for programmatic/CLI access"
  type = string
}

variable "token" {
  description = "Token for AWS SSO"
  type = string
}

variable "extra_tags" {
  description = "Extra tags which are added to all created resources"
  type        = map(string)
  default     = {"Environment": "dev", "Terraform": "true"}
}