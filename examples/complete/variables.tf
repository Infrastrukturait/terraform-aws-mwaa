variable "region" {
  type = string
}

variable "bucket_acl" {
  type    = string
  default = "private"
}

variable "name" {
  type        = string
  description = "Name of the MWAA environment."
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet Ids of the existing **private** subnets that MWAA should be used."
}

variable "vpc_id" {
  type        = string
  description = "VPC id of the VPC in which the environments resources are created."
}

variable "webserver_access_mode" {
  type        = string
  default     = "PUBLIC_ONLY"
}
