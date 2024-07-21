
variable "name" {
  type        = string
  description = "Customer name"
}

variable "tags" {
  type        = map(any)
  description = "Tags to apply to resources"
}

variable "env" {
  type        = string
  description = "Environment name"
}

variable "PrdDeployerRoleArn" {
  type        = string
  description = "ARN from Production Deployer role"
}

variable "StgDeployerRoleArn" {
  type        = string
  description = "ARN from Staging Deployer role"
}

variable "CodeStarConnectionArn" {
  type        = string
  description = "ARN from CodeStar connection"
}