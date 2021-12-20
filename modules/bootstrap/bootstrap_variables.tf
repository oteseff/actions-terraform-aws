variable "name_of_s3_bucket" {
  description = "Name of s3 bucket"
  type        = string
  default     = "actions-terraform-aws-tfstate-u4h3ue"
}
variable "dynamo_db_table_name" {
  description = "Name of s3 Dynamo DB Table"
  type        = string
  default     = "aws-locks"
}
variable "iam_user_name" {}
variable "ado_iam_role_name" {}
variable "aws_iam_policy_permits_name" {}
variable "aws_iam_policy_assume_name" {}