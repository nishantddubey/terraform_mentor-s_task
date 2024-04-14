provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = "us-east-1"
}


# Create S3 bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "iam-group-testing12345"
}

# Define IAM policies
resource "aws_iam_policy" "modify_policy" {
  name        = "s3_modify_policy"
  description = "Policy for modifying S3 buckets"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Action    = "s3:*"
      Resource  = [aws_s3_bucket.my_bucket.arn, "${aws_s3_bucket.my_bucket.arn}/*"]
    }]
  })
}

resource "aws_iam_policy" "view_policy" {
  name        = "s3_view_policy"
  description = "Policy for viewing S3 buckets"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Action    = ["s3:GetObject", "s3:ListBucket"]
      Resource  = [aws_s3_bucket.my_bucket.arn, "${aws_s3_bucket.my_bucket.arn}/*"]
    }]
  })
}

# Create IAM groups
resource "aws_iam_group" "modify_groups" {
  count = var.modify_groups_count
  name  = "ModifyGroup-${count.index + 1}"
}

resource "aws_iam_group" "view_groups" {
  count = var.view_groups_count
  name  = "ViewGroup-${count.index + 1}"
}

# Attach policies to groups
resource "aws_iam_group_policy_attachment" "modify_policy_attachment" {
  count       = var.modify_groups_count
  group       = aws_iam_group.modify_groups[count.index].name
  policy_arn  = aws_iam_policy.modify_policy.arn
}

resource "aws_iam_group_policy_attachment" "view_policy_attachment" {
  count       = var.view_groups_count
  group       = aws_iam_group.view_groups[count.index].name
  policy_arn  = aws_iam_policy.view_policy.arn
}
