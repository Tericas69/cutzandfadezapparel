terraform {

  backend "s3" {

    bucket         = "cutz-fadez-tf-state"      # TODO: replace with your real state bucket

    key            = "infra/global/terraform.tfstate"

    region         = "us-east-1"                # TODO: set your AWS region

    dynamodb_table = "cutz-fadez-tf-locks"      # TODO: replace with your DynamoDB lock table

    encrypt        = true

  }

}

 