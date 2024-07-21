resource "aws_codepipeline" "codepipeline_ecs" {

  name = "${var.application}-${var.env}-pipeline"

  role_arn = var.codepipeline_role_arn

  artifact_store {
    location = var.codepipeline_artifact_bucket
    type     = "S3"

    encryption_key {
      id   = var.kms_arn
      type = "KMS"
    }
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn    = var.codestar_connection_arn
        FullRepositoryId = var.codestar_repository_id
        BranchName       = var.codestar_repository_branch
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build_Application"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["application_build_output"]
      version          = "1"

      configuration = {
        ProjectName = aws_codebuild_project.cb_build.name
      }
    }

  }

  stage {
    name = "Deploy"

    dynamic "action" {
      for_each = var.env == "production" ? ["1"] : []
      content {
        name            = "Approval"
        category        = "Approval"
        owner           = "AWS"
        provider        = "Manual"
        version         = "1"
        run_order       = var.env == "production" ? "1" : "1"
        input_artifacts = []
        configuration = {
          CustomData = "Please approve to deploy the application"
        }
      }
    }

    action {
      name            = "Deploy"
      category        = "Build"
      owner           = "AWS"
      provider        = "CodeBuild"
      input_artifacts = ["application_build_output"]
      version         = "1"
      run_order       = var.env == "production" ? "2" : "1"

      configuration = {
        ProjectName = aws_codebuild_project.cb_deploy.name
      }
    }
  }
}
