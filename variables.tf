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

variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "ExampleAppServerInstance"
}
