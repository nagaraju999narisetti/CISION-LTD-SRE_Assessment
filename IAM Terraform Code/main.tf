provider "aws" {
  region = "us-east-1"
}

variable "name" {
  description = "Name to use for the IAM resources"
}

variable "suffix" {
  description = "Suffix to use for the IAM resources"
  default     = ""
}

resource "aws_iam_role" "role" {
  name               = "${var.name}-role${var.suffix}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { AWS = "*" }
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_policy" "policy" {
  name   = "${var.name}-policy${var.suffix}"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Action    = "sts:AssumeRole"
      Resource  = aws_iam_role.role.arn
    }]
  })
}

resource "aws_iam_group" "group" {
  name = "${var.name}-group${var.suffix}"
}

resource "aws_iam_group_policy_attachment" "group_policy_attachment" {
  group      = aws_iam_group.group.name
  policy_arn = aws_iam_policy.policy.arn
}

resource "aws_iam_user" "user" {
  name = "${var.name}-user${var.suffix}"
  groups = [
    aws_iam_group.group.name
  ]
}
