<!-- BEGIN_TF_DOCS -->
## Documentation


### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 2.0.0 |

### Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 2.0.0 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_mwaa_environment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/mwaa_environment) | resource |
| [aws_security_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy_document.assume](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.base](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_partition.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/partition) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_associated_security_group_ids"></a> [additional\_associated\_security\_group\_ids](#input\_additional\_associated\_security\_group\_ids) | Security group IDs of existing security groups that should be associated with the MWAA environment.<br>Available only when `create_security_group` is set to `true`. | `list(string)` | `[]` | no |
| <a name="input_additional_execution_role_policy_document_json"></a> [additional\_execution\_role\_policy\_document\_json](#input\_additional\_execution\_role\_policy\_document\_json) | Additional permissions to attach to the base mwaa execution role. | `string` | `"{}"` | no |
| <a name="input_airflow_configuration_options"></a> [airflow\_configuration\_options](#input\_airflow\_configuration\_options) | additional configuration to overwrite airflows standard config. | `map(string)` | `{}` | no |
| <a name="input_airflow_version"></a> [airflow\_version](#input\_airflow\_version) | Airflow version of the MWAA environment, will be set by default to the latest version that MWAA supports. | `string` | `""` | no |
| <a name="input_associated_security_group_ids"></a> [associated\_security\_group\_ids](#input\_associated\_security\_group\_ids) | A list of IDs of Security Groups to associate the created resource with, in addition to the created security group.<br>These security groups will not be modified and, if `create_security_group` is `false`, must have rules providing the desired access. | `list(string)` | `[]` | no |
| <a name="input_create_security_group"></a> [create\_security\_group](#input\_create\_security\_group) | Enabling or disabling the creation of a default Security Group for AWS MWAA | `bool` | `true` | no |
| <a name="input_dag_processing_logs_enabled"></a> [dag\_processing\_logs\_enabled](#input\_dag\_processing\_logs\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_dag_processing_logs_level"></a> [dag\_processing\_logs\_level](#input\_dag\_processing\_logs\_level) | Available log level: `DEBUG`, `INFO`, `WARNING`, `ERROR`, `CRITICAL`. | `string` | `"WARNING"` | no |
| <a name="input_dag_s3_path"></a> [dag\_s3\_path](#input\_dag\_s3\_path) | Relative path of the dags folder within the source bucket. | `string` | `"dags"` | no |
| <a name="input_environment_class"></a> [environment\_class](#input\_environment\_class) | n/a | `string` | `"mw1.small"` | no |
| <a name="input_environment_name"></a> [environment\_name](#input\_environment\_name) | Name of the MWAA environment. | `string` | n/a | yes |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | KMS CMK ARN to use by MWAA for data encryption. MUST reference the same KMS key as used by S3 bucket specified by source\_bucket\_arn, if the bucket uses KMS.<br>If not specified, the default AWS owned key for MWAA will be used for backward compatibility with version 1.0.1 of this module. | `string` | `null` | no |
| <a name="input_max_workers"></a> [max\_workers](#input\_max\_workers) | numeric string, min 1. | `string` | `"10"` | no |
| <a name="input_min_workers"></a> [min\_workers](#input\_min\_workers) | numeric string, min 1. | `string` | `"1"` | no |
| <a name="input_plugins_s3_object_version"></a> [plugins\_s3\_object\_version](#input\_plugins\_s3\_object\_version) | n/a | `string` | `null` | no |
| <a name="input_plugins_s3_path"></a> [plugins\_s3\_path](#input\_plugins\_s3\_path) | relative path of the plugins.zip within the source bucket. | `string` | `null` | no |
| <a name="input_requirements_s3_object_version"></a> [requirements\_s3\_object\_version](#input\_requirements\_s3\_object\_version) | n/a | `string` | `null` | no |
| <a name="input_requirements_s3_path"></a> [requirements\_s3\_path](#input\_requirements\_s3\_path) | relative path of the requirements.txt (incl. filename) within the source bucket. | `string` | `null` | no |
| <a name="input_scheduler_logs_enabled"></a> [scheduler\_logs\_enabled](#input\_scheduler\_logs\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_scheduler_logs_level"></a> [scheduler\_logs\_level](#input\_scheduler\_logs\_level) | Available log level: `DEBUG`, `INFO`, `WARNING`, `ERROR`, `CRITICAL`. | `string` | `"WARNING"` | no |
| <a name="input_security_group_description"></a> [security\_group\_description](#input\_security\_group\_description) | The Security Group description. Using only when `create_security_group` is set to `true`. | `string` | `"Security Group for AWS MWAA"` | no |
| <a name="input_source_bucket_arn"></a> [source\_bucket\_arn](#input\_source\_bucket\_arn) | ARN of the bucket in which DAGs, Plugin and Requirements are put. | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | Subnet Ids of the existing subnets that MWAA should be used. Must be at least 2 and **subnets must be private**. | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Map of tags to assign to bucket. | `map(string)` | `{}` | no |
| <a name="input_task_logs_enabled"></a> [task\_logs\_enabled](#input\_task\_logs\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_task_logs_level"></a> [task\_logs\_level](#input\_task\_logs\_level) | Available log level: `DEBUG`, `INFO`, `WARNING`, `ERROR`, `CRITICAL`. | `string` | `"INFO"` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC id of the VPC in which the environments resources are created. | `string` | n/a | yes |
| <a name="input_webserver_access_mode"></a> [webserver\_access\_mode](#input\_webserver\_access\_mode) | Specifies whether the webserver should be accessible over the internet or via your specified VPC.<br>Possible options: `PRIVATE_ONLY` (default) and `PUBLIC_ONLY`. | `string` | `"PRIVATE_ONLY"` | no |
| <a name="input_webserver_logs_enabled"></a> [webserver\_logs\_enabled](#input\_webserver\_logs\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_webserver_logs_level"></a> [webserver\_logs\_level](#input\_webserver\_logs\_level) | Available log level: `DEBUG`, `INFO`, `WARNING`, `ERROR`, `CRITICAL`. | `string` | `"WARNING"` | no |
| <a name="input_weekly_maintenance_window_start"></a> [weekly\_maintenance\_window\_start](#input\_weekly\_maintenance\_window\_start) | The day and time of the week in Coordinated Universal Time (UTC) 24-hour standard time to start weekly maintenance updates of your environment in the following format: DAY:HH:MM.<br>For example: TUE:03:30. You can specify a start time in 30 minute increments only. | `string` | `"MON:01:00"` | no |
| <a name="input_worker_logs_enabled"></a> [worker\_logs\_enabled](#input\_worker\_logs\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_worker_logs_level"></a> [worker\_logs\_level](#input\_worker\_logs\_level) | Available log level: DEBUG, INFO, WARNING, ERROR, CRITICAL. | `string` | `"WARNING"` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | The arn of the created MWAA environment. |
| <a name="output_webserver_url"></a> [webserver\_url](#output\_webserver\_url) | The webserver URL of the MWAA Environment. |

### Examples

```hcl
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
```

<!-- END_TF_DOCS -->