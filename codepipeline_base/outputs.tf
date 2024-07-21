output "codepipeline_kms_arn" {
  value       = aws_kms_key.encryption_key.arn
  description = "CodePipeline KMS Arn"
}

output "codepipeline_role_arn" {
  value       = aws_iam_role.codepipeline_role.arn
  description = "CodePipeline IAM Role ARN"
}

output "codepipeline_artifact_bucket" {
  value       = aws_s3_bucket.cp_artifact_bucket.bucket
  description = "CodePipeline Artifact Bucket"
}