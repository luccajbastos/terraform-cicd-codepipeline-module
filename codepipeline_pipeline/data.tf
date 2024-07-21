####################
### ACCOUNT DATA ###
####################

data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}
data "aws_region" "current" {}


###############################
### CODEBUILD BUILD SECRETS ###
###############################

data "aws_secretsmanager_secret" "build_secrets" {
  arn = var.build_secret_arn
}

data "aws_secretsmanager_secret_version" "build_secrets_version" {
  secret_id = data.aws_secretsmanager_secret.build_secrets.id
}

################################
### CODEBUILD DOCKER SECRETS ###
################################

data "aws_secretsmanager_secret" "docker_secrets" {
  arn = var.docker_secret_arn
}

data "aws_secretsmanager_secret_version" "docker_secrets_version" {
  secret_id = data.aws_secretsmanager_secret.docker_secrets.id
}