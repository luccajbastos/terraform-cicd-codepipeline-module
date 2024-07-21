locals {

  environment       = var.environment
  name              = var.name
  connection_arn    = var.connection_arn
  state_bucket_name = "luccajbastos-terraform-state"

  tags = {
    environment = var.environment
  }
}

##############################
## CODEPIPELINE BASE MODULE ##
##############################

module "codepipeline_base" {
  source = "./modules/codepipeline_base"

  name                  = local.name
  env                   = local.environment
  tags                  = local.tags
  PrdDeployerRoleArn    = var.PrdDeployerRoleArn
  StgDeployerRoleArn    = var.StgDeployerRoleArn
  CodeStarConnectionArn = local.connection_arn
}

################
## PRODUCTION ##
################

#########################
## (PRD) APP1 PIPELINE ##
#########################

module "pipeline_prd_app1" {
  source     = "./modules/codepipeline_pipeline"
  depends_on = [module.codepipeline_base]

  # Configuração geral
  env                          = "production"
  application                  = "app1"
  docker_secret_arn            = "arn:aws:secretsmanager:us-east-1:730335633389:secret:DOCKERHUB-fiYZPu"
  codepipeline_role_arn        = module.codepipeline_base.codepipeline_role_arn
  codepipeline_artifact_bucket = module.codepipeline_base.codepipeline_artifact_bucket
  terraform_state_bucket       = local.state_bucket_name

  # Configuração de repositório 
  codestar_connection_arn    = local.connection_arn
  codestar_repository_id     = "luccajbastos/app1"
  codestar_repository_branch = "production"

  # Configuração de build
  build_codebuild_buildspec_path = "./infrastructure/prd/buildspecs/build.buildspec.yml"
  build_secret_arn               = "arn:aws:secretsmanager:us-east-1:730335633389:secret:luccajbastos/production/app1-Nt2ReY"
  kms_arn                        = module.codepipeline_base.codepipeline_kms_arn

  build_custom_envs = {
    AWS_ACCOUNT_ID     = data.aws_caller_identity.current.account_id
    AWS_DEFAULT_REGION = data.aws_region.current.name
  }

  # Configuração de deploy
  deploy_codebuild_buildspec_path  = "./infrastructure/prd/buildspecs/deploy.buildspec.yml"
  deploy_codebuild_deployment_role = var.PrdDeployerRoleArn

  deploy_custom_envs = {
    TERRAFORM_PATH       = "infrastructure/prd/app1"
  }
}

#############
## STAGING ##
#############

#################################
## (STG) app1 PIPELINE ##
#################################

module "pipeline_stg_new_checkout" {
  source     = "./modules/codepipeline_pipeline"
  depends_on = [module.codepipeline_base]

  # Configuração geral
  env                          = "staging"
  application                  = "app1"
  docker_secret_arn            = "arn:aws:secretsmanager:us-east-1:730335633389:secret:DOCKERHUB-fiYZPu"
  codepipeline_role_arn        = module.codepipeline_base.codepipeline_role_arn
  codepipeline_artifact_bucket = module.codepipeline_base.codepipeline_artifact_bucket
  terraform_state_bucket       = local.state_bucket_name

  # Configuração de repositório 
  codestar_connection_arn    = local.connection_arn
  codestar_repository_id     = "luccajbastos/app1"
  codestar_repository_branch = "staging"

  # Configuração de build
  build_codebuild_buildspec_path = "./infrastructure/stg/buildspecs/build.buildspec.yml"
  build_secret_arn               = "arn:aws:secretsmanager:us-east-1:730335633389:secret:luccajbastos/staging/app1-5SFdBF"
  kms_arn                        = module.codepipeline_base.codepipeline_kms_arn

  build_custom_envs = {
    AWS_ACCOUNT_ID     = data.aws_caller_identity.current.account_id
    AWS_DEFAULT_REGION = data.aws_region.current.name
    IMAGE_TAG          = "latest"
  }

  # Configuração de deploy
  deploy_codebuild_buildspec_path  = "./infrastructure/stg/buildspecs/deploy.buildspec.yml"
  deploy_codebuild_deployment_role = var.StgDeployerRoleArn

  deploy_custom_envs = {
    TERRAFORM_PATH       = "infrastructure/stg/app1"
  }
}

