## Requirements

CodePipeline Base Module

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_codebuild_project.cb_build](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |
| [aws_codebuild_project.cb_deploy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codebuild_project) | resource |
| [aws_codepipeline.codepipeline_ecs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/codepipeline) | resource |
| [aws_ecr_lifecycle_policy.lifecycle](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy) | resource |
| [aws_ecr_repository.ecr-repository](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |
| [aws_ecr_repository_policy.ecr_polcy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository_policy) | resource |
| [aws_iam_policy.codebuild_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.codebuild_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.codebuild_attach_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.ecr_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_secretsmanager_secret.build_secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret) | data source |
| [aws_secretsmanager_secret.docker_secrets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret) | data source |
| [aws_secretsmanager_secret_version.build_secrets_version](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |
| [aws_secretsmanager_secret_version.docker_secrets_version](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_application"></a> [application](#input\_application) | Application Name | `string` | n/a | yes |
| <a name="input_build_codebuild_buildspec_path"></a> [build\_codebuild\_buildspec\_path](#input\_build\_codebuild\_buildspec\_path) | Path to the buildspec file for build | `string` | n/a | yes |
| <a name="input_build_custom_envs"></a> [build\_custom\_envs](#input\_build\_custom\_envs) | Custom Environment variables for build | `map(string)` | n/a | yes |
| <a name="input_build_secret_arn"></a> [build\_secret\_arn](#input\_build\_secret\_arn) | Secret Manager Arn for build environment variables | `string` | n/a | yes |
| <a name="input_builder_compute_type"></a> [builder\_compute\_type](#input\_builder\_compute\_type) | CodeBuild instance type for builder | `string` | `"BUILD_GENERAL1_MEDIUM"` | no |
| <a name="input_builder_image"></a> [builder\_image](#input\_builder\_image) | CodeBuild builder image | `string` | `"aws/codebuild/amazonlinux2-x86_64-standard:5.0"` | no |
| <a name="input_builder_type"></a> [builder\_type](#input\_builder\_type) | CodeBuild builder type | `string` | `"LINUX_CONTAINER"` | no |
| <a name="input_codepipeline_artifact_bucket"></a> [codepipeline\_artifact\_bucket](#input\_codepipeline\_artifact\_bucket) | CodePipeline Artifact Bucket Name | `string` | n/a | yes |
| <a name="input_codepipeline_role_arn"></a> [codepipeline\_role\_arn](#input\_codepipeline\_role\_arn) | CodePipeline IAM Role Arn | `string` | n/a | yes |
| <a name="input_codestar_connection_arn"></a> [codestar\_connection\_arn](#input\_codestar\_connection\_arn) | CodeStar Connection Arn | `string` | n/a | yes |
| <a name="input_codestar_repository_branch"></a> [codestar\_repository\_branch](#input\_codestar\_repository\_branch) | CodeStar Repository Branch | `string` | n/a | yes |
| <a name="input_codestar_repository_id"></a> [codestar\_repository\_id](#input\_codestar\_repository\_id) | CodeStar Repository Id | `string` | n/a | yes |
| <a name="input_deploy_codebuild_buildspec_path"></a> [deploy\_codebuild\_buildspec\_path](#input\_deploy\_codebuild\_buildspec\_path) | Path to the buildspec file for deploy | `string` | n/a | yes |
| <a name="input_deploy_codebuild_deployment_role"></a> [deploy\_codebuild\_deployment\_role](#input\_deploy\_codebuild\_deployment\_role) | CodeBuild Deployment Role Arn | `string` | n/a | yes |
| <a name="input_deploy_custom_envs"></a> [deploy\_custom\_envs](#input\_deploy\_custom\_envs) | Custom Environment variables for deploy | `map(string)` | n/a | yes |
| <a name="input_docker_secret_arn"></a> [docker\_secret\_arn](#input\_docker\_secret\_arn) | Secret Manager Arn for Docker Credentials | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Environment Name | `string` | n/a | yes |
| <a name="input_kms_arn"></a> [kms\_arn](#input\_kms\_arn) | CodeBuild KMS Key Arn | `string` | n/a | yes |
| <a name="input_terraform_state_bucket"></a> [terraform\_state\_bucket](#input\_terraform\_state\_bucket) | n/a | `string` | `"Terraform State Bucket Name"` | no |

## Outputs

No outputs.