resource "aws_iam_role" "codebuild_role" {
  name               = "${var.application}-${var.env}-codebuild-role"
  assume_role_policy = <<EOF
        {
        "Version": "2012-10-17",
        "Statement": [
            {
            "Effect": "Allow",
            "Principal": {
                "Service": "codebuild.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
            }
        ]
        }
    EOF
}

resource "aws_iam_policy" "codebuild_policy" {
  name   = "${aws_iam_role.codebuild_role.name}-policy"
  policy = <<EOF
      {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": [
                    "s3:*"
                ],
                "Resource": [
                    "arn:${data.aws_partition.current.partition}:s3:::${var.codepipeline_artifact_bucket}/*",
                    "arn:${data.aws_partition.current.partition}:s3:::${var.codepipeline_artifact_bucket}"
                ]
            },
            {
                "Effect": "Allow",
                "Action": [
                    "secretsmanager:GetSecretValue"
                ],
                "Resource": "*"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "logs:CreateLogGroup",
                    "logs:CreateLogStream",
                    "logs:PutLogEvents"
                ],
                "Resource": "arn:${data.aws_partition.current.partition}:logs:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:log-group:*"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "kms:DescribeKey",
                    "kms:GenerateDataKey*",
                    "kms:Encrypt",
                    "kms:ReEncrypt*",
                    "kms:Decrypt"
                ],
                "Resource": "${var.kms_arn}"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "ecr:*"
                ],
                "Resource": "${aws_ecr_repository.ecr-repository.arn}"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "ecr:GetAuthorizationToken"
                ],
                "Resource": "*"
            },
            {
                "Effect": "Allow",
                "Action": [
                    "s3:*"
                ],
                "Resource": [
                    "arn:${data.aws_partition.current.partition}:s3:::${var.terraform_state_bucket}/*",
                    "arn:${data.aws_partition.current.partition}:s3:::${var.terraform_state_bucket}"
                ]
            },
            {  
                "Action": [
                    "sts:AssumeRole",
                    "iam:PassRole"
                ],
                "Resource": [
                    "${var.deploy_codebuild_deployment_role}"
                ],
                "Effect": "Allow"
            }
        ]
    }
  EOF
}

resource "aws_iam_role_policy_attachment" "codebuild_attach_policy" {
  role       = aws_iam_role.codebuild_role.name
  policy_arn = aws_iam_policy.codebuild_policy.arn
}