terraform {
  backend "s3" {
    bucket = "lucca-terraform-state-bucket"
    key    = "ci-cd/state.tfstate"
    region = "us-east-1"
  }
}