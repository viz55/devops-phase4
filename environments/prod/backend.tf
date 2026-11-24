terraform {
  backend "s3" {
    bucket         = "devops-phase4-tfstate-0825a705"
    key            = "prod/terraform.tfstate"
    region         = "ap-southeast-2"
    encrypt        = true
    dynamodb_table = "devops-phase4-tflock"
  }
}
