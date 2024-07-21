#Artifact Bucket
resource "aws_s3_bucket" "cp_artifact_bucket" {
  bucket_prefix = regex("[a-z0-9.-]+", lower(var.name))
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "codepipeline_bucket_access" {
  bucket                  = aws_s3_bucket.cp_artifact_bucket.id
  ignore_public_acls      = true
  restrict_public_buckets = true
  block_public_acls       = true
  block_public_policy     = true
}

resource "aws_s3_bucket_policy" "bucket_policy_codepipeline_bucket" {
  bucket = aws_s3_bucket.cp_artifact_bucket.id
  policy = data.aws_iam_policy_document.bucket_policy_doc_codepipeline_bucket.json
}

data "aws_iam_policy_document" "bucket_policy_doc_codepipeline_bucket" {
  statement {
    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.codepipeline_role.arn]
    }

    actions = [
      "s3:Get*",
      "s3:List*",
      "s3:ReplicateObject",
      "s3:PutObject",
      "s3:RestoreObject",
      "s3:PutObjectVersionTagging",
      "s3:PutObjectTagging",
      "s3:PutObjectAcl"
    ]

    resources = [
      "${aws_s3_bucket.cp_artifact_bucket.arn}/*",
      "${aws_s3_bucket.cp_artifact_bucket.arn}"
    ]
  }
}

resource "aws_s3_bucket_versioning" "codepipeline_bucket_versioning" {
  bucket = aws_s3_bucket.cp_artifact_bucket.bucket
  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_s3_bucket_server_side_encryption_configuration" "codepipeline_bucket_encryption" {
  bucket = aws_s3_bucket.cp_artifact_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.encryption_key.id
      sse_algorithm     = "aws:kms"
    }
  }
}

