# CodePipeline CI/CD Module w/ Terraform

With these modules, it is possible to create fully customizable pipelines using AWS CodePipeline, AWS CodeBuild, and CodeStar services to connect external repositories.

## Module: codepipeline_base

This module provisions essential resources for the pipeline to function, including:

- Artifact bucket
- Roles and Policies
- KMS Key

For more details, please refer to the module's [README.md](codepipeline_base/README.md) where you will find the parameter descriptions.

## Module: codepipeline_pipeline

With this module, you can provision the CI/CD pipeline.

For more details, please refer to the module's [README.md](codepipeline_pipeline/README.md) where you will find the parameter descriptions.

## Usage Example

[Here](examples) you will find an example of how to use the module.

## Buildspecs de exemplo

The buildspec contains the steps that CodeBuild follows to build the application.

Exemplos:
- [Build (docker) and deploy (terraform) steps](buildspecs/build-deploy-buildspecs)
- [Terraform Validate/Plan/Apply steps](buildspecs/terraform-buildspecs)


