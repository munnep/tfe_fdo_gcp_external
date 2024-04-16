variable "tag_prefix" {
  description = "default prefix of names"
}

variable "vnet_cidr" {
  description = "which private subnet do you want to use for the VPC. Subnet mask of /16"
}


variable "public_key" {
  type        = string
  description = "public to use on the instances"
}

variable "tfe_password" {
  description = "password for tfe user"
}

variable "dns_hostname" {
  type        = string
  description = "DNS name you use to access the website"
}

variable "dns_zonename" {
  type        = string
  description = "DNS zone the record should be created in"
}

variable "tfe_release" {
  description = "Which release version of TFE to install"
}

variable "tfe_license" {
  description = "the TFE license as a string"
}

variable "aws_region" {
  description = "region to create the environment"
}

variable "gcp_region" {
  description = "region to create the environment"
}

variable "gcp_project" {
  description = "project for the resources to use"
}

variable "gcp_location" {
  description = "location where the bucket is stored"
}

variable "certificate_email" {
  description = "email address to register the certificate"
}

variable "rds_password" {
  description = "password used to connect to database"
}