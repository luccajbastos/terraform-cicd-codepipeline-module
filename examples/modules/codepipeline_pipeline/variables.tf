variable "application" {
  type        = string
  description = "Application Name"
}

variable "env" {
  type        = string
  description = "Environment Name"
}

variable "builder_compute_type" {
  type        = string
  description = "CodeBuild instance type for builder"
  default     = "BUILD_GENERAL1_MEDIUM"
}

variable "builder_image" {
  type        = string
  description = "CodeBuild builder image"
  default     = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
}

variable "builder_type" {
  type        = string
  description = "CodeBuild builder type"
  default     = "LINUX_CONTAINER"
}

variable "build_secret_arn" {
  type        = string
  description = "Secret Manager Arn for build environment variables"
}

variable "docker_secret_arn" {
  type        = string
  description = "Secret Manager Arn for Docker Credentials"
}

variable "kms_arn" {
  type        = string
  description = "CodeBuild KMS Key Arn"
}

variable "terraform_state_bucket" {
  type    = string
  default = "Terraform State Bucket Name"
}

variable "deploy_codebuild_buildspec_path" {
  type        = string
  description = "Path to the buildspec file for deploy"
}

variable "build_codebuild_buildspec_path" {
  type        = string
  description = "Path to the buildspec file for build"
}

variable "codepipeline_role_arn" {
  type        = string
  description = "CodePipeline IAM Role Arn"
}

variable "codepipeline_artifact_bucket" {
  type        = string
  description = "CodePipeline Artifact Bucket Name"
}

variable "codestar_connection_arn" {
  type        = string
  description = "CodeStar Connection Arn"
}

variable "codestar_repository_id" {
  type        = string
  description = "CodeStar Repository Id"
}

variable "codestar_repository_branch" {
  type        = string
  description = "CodeStar Repository Branch"
}

variable "build_custom_envs" {
  type        = map(string)
  description = "Custom Environment variables for build"
}

variable "deploy_custom_envs" {
  type        = map(string)
  description = "Custom Environment variables for deploy"
}

variable "deploy_codebuild_deployment_role" {
  type        = string
  description = "CodeBuild Deployment Role Arn"
}
