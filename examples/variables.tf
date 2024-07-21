variable "environment" {
  type = string
}

variable "name" {
  type = string
}

variable "connection_arn" {
  type = string
}


variable "PrdDeployerRoleArn" {
  type = string
}

variable "target_bucket_name" {
  type    = string
  default = "null"
}

variable "StgDeployerRoleArn" {
  type = string
}