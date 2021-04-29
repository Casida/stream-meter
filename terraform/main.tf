provider "aws" {
  region = "us-east-2"
}

resource "aws_ecr_repository" "stream-meter" {
  name = "stream-meter"
}
