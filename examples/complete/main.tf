module "app_prod_airflow_label" {
  source   = "cloudposse/label/null"
  version = "v0.25.0"

  name       = var.name

  namespace  = "app"
  stage      = "prod"
  delimiter  = "-"

  tags = {
    "BusinessUnit" = "XYZ",
  }
}

module "app_prod_airflow_bucket" {
  source                      = "Infrastrukturait/s3-bucket/aws"
  version                     = "0.4.0"
  bucket_name                 = join(module.app_prod_airflow_label.delimiter, [module.app_prod_airflow_label.stage, module.app_prod_airflow_label.name])
  bucket_acl                  = var.bucket_acl

  tags                        = module.app_prod_airflow_label.tags
}

module "app_prod_airflow" {
  source                = "../../"
  environment_name      = join(module.app_prod_airflow_label.delimiter, [module.app_prod_airflow_label.stage, module.app_prod_airflow_label.name])
  subnet_ids            = var.subnet_ids
  vpc_id                = var.vpc_id
  webserver_access_mode = var.webserver_access_mode

  source_bucket_arn     = module.app_prod_airflow_bucket.arn

  tags                  = module.app_prod_airflow_label.tags
}
