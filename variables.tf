variable "environment_name" {
  type        = string
  description = "Name of the MWAA environment."
}

variable "airflow_version" {
  type        = string
  default     = ""
  description = "Airflow version of the MWAA environment, will be set by default to the latest version that MWAA supports."
}

variable "source_bucket_arn" {
  type        = string
  description = "ARN of the bucket in which DAGs, Plugin and Requirements are put."
}

variable "dag_s3_path" {
  type        = string
  default     = "dags"
  description = "Relative path of the dags folder within the source bucket."

}

variable "plugins_s3_path" {
  type        = string
  default     = null
  description = "relative path of the plugins.zip within the source bucket."
}

variable "plugins_s3_object_version" {
  default     = null
  type        = string
  description = "The plugins.zip file version you want to use."
}

variable "requirements_s3_path" {
  type        = string
  default     = null
  description = "relative path of the requirements.txt (incl. filename) within the source bucket."
}

variable "requirements_s3_object_version" {
  default     = null
  type        = string
  description = "The requirements.txt file version you want to use."
}

variable "airflow_configuration_options" {
  type        = map(string)
  default     = {}
  description = "additional configuration to overwrite airflows standard config."

}

variable "vpc_id" {
  type        = string
  description = "VPC id of the VPC in which the environments resources are created."
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet Ids of the existing subnets that MWAA should be used. Must be at least 2 and **subnets must be private**."
  validation {
    condition     = length(var.subnet_ids) == 2
    error_message = "Must be at least 2 subnets."
  }
}

variable "create_security_group" {
  type        = bool
  default     = true
  description = "Enabling or disabling the creation of a default Security Group for AWS MWAA"
}

variable "security_group_description" {
  type        = string
  default     = "Security Group for AWS MWAA"
  description = "The Security Group description. Using only when `create_security_group` is set to `true`."
}

variable "associated_security_group_ids" {
  type        = list(string)
  default     = []
  description = <<-EOT
    A list of IDs of Security Groups to associate the created resource with, in addition to the created security group.
    These security groups will not be modified and, if `create_security_group` is `false`, must have rules providing the desired access.
  EOT
}

variable "additional_associated_security_group_ids" {
  type        = list(string)
  default     = []
  description = <<-EOT
    Security group IDs of existing security groups that should be associated with the MWAA environment.
    Available only when `create_security_group` is set to `true`.
  EOT
}

variable "additional_execution_role_policy_document_json" {
  type        = string
  default     = "{}"
  description = "Additional permissions to attach to the base mwaa execution role."
}

variable "max_workers" {
  default     = "10"
  type        = string
  description = "numeric string, min 1."
}

variable "min_workers" {
  default     = "1"
  type        = string
  description = "numeric string, min 1."
}

variable "environment_class" {
  type        = string
  default     = "mw1.small"
  description = <<-EOT
    Environment class for the cluster. Possible options are `mw1.small`, `mw1.medium`, `mw1.large`. Will be set by default to `mw1.small`.
    Please check the [AWS Pricing](https://aws.amazon.com/de/managed-workflows-for-apache-airflow/pricing/) for more information about the environment classes.
  EOT
}

variable "webserver_access_mode" {
  type        = string
  default     = "PRIVATE_ONLY"
  description = <<-EOT
    Specifies whether the webserver should be accessible over the internet or via your specified VPC.
    Possible options: `PRIVATE_ONLY` (default) and `PUBLIC_ONLY`.
  EOT
  validation {
    condition     = contains(["PRIVATE_ONLY", "PUBLIC_ONLY"], var.webserver_access_mode)
    error_message = "Valid options for webserver_access_mode: `PRIVATE_ONLY` and `PUBLIC_ONLY`."
  }
}

variable "kms_key_arn" {
  type        = string
  default     = null
  description = <<-EOT
    KMS CMK ARN to use by MWAA for data encryption. MUST reference the same KMS key as used by S3 bucket specified by source_bucket_arn, if the bucket uses KMS.
    If not specified, the default AWS owned key for MWAA will be used for backward compatibility with version 1.0.1 of this module.
  EOT
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Map of tags to assign to bucket."
}

variable "dag_processing_logs_enabled" {
  type        = bool
  default     = true
  description = "Enabling or disabling the collection of logs"
}

variable "dag_processing_logs_level" {
  type        = string
  default     = "WARNING"
  description = "Available log level: `DEBUG`, `INFO`, `WARNING`, `ERROR`, `CRITICAL`."
  validation {
    condition     = contains(["DEBUG", "INFO", "WARNING", "ERROR", "CRITICAL"], var.dag_processing_logs_level)
    error_message = "Valid log levels for dag_processing_logs_level: `DEBUG`, `INFO`, `WARNING`, `ERROR`, `CRITICAL`."
  }
}

variable "scheduler_logs_enabled" {
  type        = bool
  default     = true
  description = "Enabling or disabling the collection of logs"
}

variable "scheduler_logs_level" {
  type        = string
  default     = "WARNING"
  description = "Available log level: `DEBUG`, `INFO`, `WARNING`, `ERROR`, `CRITICAL`."
  validation {
    condition     = contains(["DEBUG", "INFO", "WARNING", "ERROR", "CRITICAL"], var.scheduler_logs_level)
    error_message = "Valid log levels for scheduler_logs_level: `DEBUG`, `INFO`, `WARNING`, `ERROR`, `CRITICAL`."
  }
}

variable "task_logs_enabled" {
  type        = bool
  default     = true
  description = "Enabling or disabling the collection of logs"
}

variable "task_logs_level" {
  type        = string
  default     = "INFO"
  description = "Available log level: `DEBUG`, `INFO`, `WARNING`, `ERROR`, `CRITICAL`."
  validation {
    condition     = contains(["DEBUG", "INFO", "WARNING", "ERROR", "CRITICAL"], var.task_logs_level)
    error_message = "Valid log levels for task_logs_level: `DEBUG`, `INFO`, `WARNING`, `ERROR`, `CRITICAL`."
  }
}

variable "webserver_logs_enabled" {
  type        = bool
  default     = true
  description = "Enabling or disabling the collection of logs"
}

variable "webserver_logs_level" {
  type        = string
  default     = "WARNING"
  description = "Available log level: `DEBUG`, `INFO`, `WARNING`, `ERROR`, `CRITICAL`."
  validation {
    condition     = contains(["DEBUG", "INFO", "WARNING", "ERROR", "CRITICAL"], var.webserver_logs_level)
    error_message = "Valid log levels for webserver_logs_level: `DEBUG`, `INFO`, `WARNING`, `ERROR`, `CRITICAL`."
  }
}

variable "worker_logs_enabled" {
  type        = bool
  default     = true
  description = "Enabling or disabling the collection of logs"
}

variable "worker_logs_level" {
  type        = string
  default     = "WARNING"
  description = "Available log level: DEBUG, INFO, WARNING, ERROR, CRITICAL."
  validation {
    condition     = contains(["DEBUG", "INFO", "WARNING", "ERROR", "CRITICAL"], var.worker_logs_level)
    error_message = "Valid log levels for worker_logs_level: `DEBUG`, `INFO`, `WARNING`, `ERROR`, `CRITICAL`."
  }
}

variable "weekly_maintenance_window_start" {
  type        = string
  default     = "MON:01:00"
  description = <<-EOT
    The day and time of the week in Coordinated Universal Time (UTC) 24-hour standard time to start weekly maintenance updates of your environment in the following format: DAY:HH:MM.
    For example: TUE:03:30. You can specify a start time in 30 minute increments only.
  EOT
}
