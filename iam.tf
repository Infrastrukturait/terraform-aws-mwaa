data "aws_region" "current" {}
data "aws_partition" "current" {}
data "aws_caller_identity" "current" {}

locals {
  account_id             = data.aws_caller_identity.current.account_id
  partition              = data.aws_partition.current.partition
  region                 = data.aws_region.current.name
}

resource "aws_iam_role" "this" {
  name               = "mwaa-${var.environment_name}-execution-role"
  assume_role_policy = data.aws_iam_policy_document.assume.json
  tags               = var.tags
}

resource "aws_iam_role_policy" "this" {
  name   = "mwaa-${var.environment_name}-execution-policy"
  policy = data.aws_iam_policy_document.this.json
  role   = aws_iam_role.this.id
}

data "aws_iam_policy_document" "assume" {
  version = "2012-10-17"
  statement {
    effect  = "Allow"
    principals {
      identifiers = [
        "airflow-env.amazonaws.com",
        "airflow.amazonaws.com"
      ]
      type        = "Service"
    }
    actions = [
      "sts:AssumeRole"
    ]
  }
}

data "aws_iam_policy_document" "base" {
  version = "2012-10-17"
  statement {
    effect    = "Allow"
    actions   = [
      "airflow:PublishMetrics"
    ]
    resources = [
      "arn:${local.partition}:airflow:${local.region}:${local.account_id}:environment/${var.environment_name}"
    ]
  }
  statement {
    effect    = "Deny"
    actions   = ["s3:ListAllMyBuckets"]
    resources = [
      var.source_bucket_arn,
      "${var.source_bucket_arn}/*",
    ]
  }
  statement {
    effect    = "Allow"
    actions   = [
      "s3:GetObject*",
      "s3:GetBucket*",
      "s3:List*"
    ]
    resources = [
      var.source_bucket_arn,
      "${var.source_bucket_arn}/*",
    ]
  }
  statement {
    effect    = "Allow"
    actions   = [
      "s3:GetAccountPublicAccessBlock"
    ]
    resources = ["*"]
  }
  statement {
    effect    = "Allow"
    actions   = [
      "logs:CreateLogStream",
      "logs:CreateLogGroup",
      "logs:PutLogEvents",
      "logs:GetLogEvents",
      "logs:GetLogRecord",
      "logs:GetLogGroupFields",
      "logs:GetQueryResults"
    ]
    resources = [
      "arn:${local.partition}:logs:${local.region}:${local.account_id}:log-group:airflow-${var.environment_name}-*"
    ]
  }
  statement {
    effect    = "Allow"
    actions   = [
      "logs:DescribeLogGroups"
    ]
    resources = [
      "*"
    ]
  }
  statement {

    effect    = "Allow"
    actions   = [
      "cloudwatch:PutMetricData"
    ]
    resources = [
      "*"
    ]
  }
  statement {
    effect    = "Allow"
    actions   = [
      "sqs:ChangeMessageVisibility",
      "sqs:DeleteMessage",
      "sqs:GetQueueAttributes",
      "sqs:GetQueueUrl",
      "sqs:ReceiveMessage",
      "sqs:SendMessage"
    ]
    resources = [
      "arn:${local.partition}:sqs:${local.region}:*:airflow-celery-*"
    ]
  }
  statement {
    effect        = "Allow"
    actions       = [
      "kms:Decrypt",
      "kms:DescribeKey",
      "kms:GenerateDataKey*",
      "kms:Encrypt"
    ]
    resources     = var.kms_key_arn != null ? [
      var.kms_key_arn
    ] : []
    not_resources = var.kms_key_arn == null ? [
      "arn:${local.partition}:kms:*:${local.account_id}:key/*"
    ] : []
    condition {
      test     = "StringLike"
      values   = var.kms_key_arn != null ? [
        "sqs.${local.region}.amazonaws.com",
        "s3.${local.region}.amazonaws.com"
      ] : [
        "sqs.${local.region}.amazonaws.com"
      ]
      variable = "kms:ViaService"
    }
  }
}

data "aws_iam_policy_document" "this" {
  source_policy_documents = [
    data.aws_iam_policy_document.base.json,
    var.additional_execution_role_policy_document_json
  ]
}
