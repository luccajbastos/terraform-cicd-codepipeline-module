

resource "aws_codebuild_project" "cb_build" {

  name           = "${var.application}-${var.env}-build-codebuild"
  service_role   = aws_iam_role.codebuild_role.arn
  encryption_key = var.kms_arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = var.builder_compute_type
    image                       = var.builder_image
    type                        = var.builder_type
    privileged_mode             = false
    image_pull_credentials_type = "CODEBUILD"

    dynamic "environment_variable" {
      for_each = jsondecode(nonsensitive(data.aws_secretsmanager_secret_version.build_secrets_version.secret_string))
      content {
        name  = environment_variable.key
        value = "${data.aws_secretsmanager_secret_version.build_secrets_version.arn}:${environment_variable.key}"
        type  = "SECRETS_MANAGER"
      }
    }

    dynamic "environment_variable" {
      for_each = jsondecode(nonsensitive(data.aws_secretsmanager_secret_version.docker_secrets_version.secret_string))
      content {
        name  = environment_variable.key
        value = "${data.aws_secretsmanager_secret_version.docker_secrets_version.arn}:${environment_variable.key}"
        type  = "SECRETS_MANAGER"
      }
    }

    dynamic "environment_variable" {
      for_each = var.build_custom_envs
      content {
        name  = environment_variable.key
        value = environment_variable.value
        type  = "PLAINTEXT"
      }
    }

    environment_variable {
      name  = "REPOSITORY_URI"
      value = aws_ecr_repository.ecr-repository.repository_url
      type  = "PLAINTEXT"
    }

  }

  logs_config {
    cloudwatch_logs {
      status = "ENABLED"
    }
  }
  source {
    type      = "CODEPIPELINE"
    buildspec = var.build_codebuild_buildspec_path
  }
}

resource "aws_codebuild_project" "cb_deploy" {

  name           = "${var.application}-${var.env}-deploy-codebuild"
  service_role   = aws_iam_role.codebuild_role.arn
  encryption_key = var.kms_arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = var.builder_compute_type
    image                       = var.builder_image
    type                        = var.builder_type
    privileged_mode             = false
    image_pull_credentials_type = "CODEBUILD"

    # environment_variable {
    #   name  = "TERRAFORM_PATH"
    #   value =  var.deploy_codebuild_terraform_files_path
    #   type  = "PLAINTEXT"
    # }

    environment_variable {
      name  = "TARGET_DEPLOYMENT_ROLE"
      value = var.deploy_codebuild_deployment_role
      type  = "PLAINTEXT"
    }

    dynamic "environment_variable" {
      for_each = var.deploy_custom_envs
      content {
        name  = environment_variable.key
        value = environment_variable.value
        type  = "PLAINTEXT"
      }
    }

  }
  logs_config {
    cloudwatch_logs {
      status = "ENABLED"
    }
  }
  source {
    type      = "CODEPIPELINE"
    buildspec = var.deploy_codebuild_buildspec_path
  }
}
