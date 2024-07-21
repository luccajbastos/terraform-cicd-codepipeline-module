resource "aws_iam_role" "codepipeline_role" {
  name               = "${var.name}-${var.env}-codepipeline-role"
  assume_role_policy = <<EOF
        {
        "Version": "2012-10-17",
        "Statement": [
            {
            "Action": "sts:AssumeRole",
            "Principal": {
                "Service": "codepipeline.amazonaws.com"
            },
            "Effect": "Allow"
            },
            {
            "Effect": "Allow",
            "Principal": {
                "AWS": "${data.aws_caller_identity.current.account_id}"
            },
            "Action": "sts:AssumeRole"
            }
        ]
        }
        EOF
  path               = "/"
}

resource "aws_iam_policy" "codepipeline_policy" {
  name        = "${aws_iam_role.codepipeline_role.name}-codepipeline-policy"
  description = "Policy to allow codepipeline to execute"
  #   tags        = var.tags
  policy = <<EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": [
                    "codebuild:BatchGetBuilds",
                    "codebuild:StartBuild",
                    "codebuild:BatchGetProjects"
                ],
                "Resource": [
                    "arn:aws:codebuild:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:project/*"
                ]
            },
            {
                "Effect": "Allow",
                "Action": [
                    "codebuild:CreateReportGroup",
                    "codebuild:CreateReport",
                    "codebuild:UpdateReport",
                    "codebuild:BatchPutTestCases"
                ],
                "Resource": [
                    "arn:aws:codebuild:${data.aws_region.current.id}:${data.aws_caller_identity.current.account_id}:project/*"
                ]
            },
            {
                "Effect": "Allow",
                "Action": [
                    "ecr:*",
                    "iam:*",
                    "elasticloadbalancing:*",
                    "ecs:*"
                ],
                "Resource": "*"
            },
            {
                "Action": [
                    "codestar-connections:UseConnection"
                ],
                "Resource": "${var.CodeStarConnectionArn}",
                "Effect": "Allow"
            },
            {
                "Action": [
                    "sts:AssumeRole",
                    "iam:PassRole"
                ],
                "Resource": [
                    "${var.PrdDeployerRoleArn}",
                    "${var.StgDeployerRoleArn}"
                ],
                "Effect": "Allow"
            }
        ]
    }
    EOF
}

resource "aws_iam_role_policy_attachment" "codepipeline_role_attach" {
  role       = aws_iam_role.codepipeline_role.name
  policy_arn = aws_iam_policy.codepipeline_policy.arn
}