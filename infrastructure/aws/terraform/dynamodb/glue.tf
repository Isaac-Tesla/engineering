resource "aws_glue_catalog_database" "aws_glue_catalog_database" {
  name = "TechIntCatalogDatabase"
}

resource "aws_glue_crawler" "example" {
  database_name = aws_glue_catalog_database.aws_glue_catalog_database.name
  name          = "techint"
  role          = aws_iam_role.iam_glue_service_role.arn

  dynamodb_target {
    path = aws_dynamodb_table.dynamodb-table.name
  }
}

# IAM role for Glue Service
resource "aws_iam_role" "iam_glue_service_role" {
  name = "iam_glue_service_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "glue.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}
