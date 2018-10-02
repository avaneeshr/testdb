
variable "aws_region" {
  description = "The AWS region to build network infrastructure"
  type        = "string"
}
variable "instance_count" {
  type        = "string"
  description = "Windows instance count"
  default = 1
}

variable "instance_type" {
  type        = "string"
  description = "Windows instance_type"
  default = "t2.micro"
}

variable "key_name" {
  type        = "string"
  description = "Key for Win Server Login"
  default = "EC2KeyPair"
}
variable "env_name" {
  description = "Specific which env name (dev, test, prod)"
  type        = "string"
  default     = "QA"
}


variable "role" {
  description = "Role"
  type        = "string"
  default     = "DB"
}

variable "asv" {
  description = "ASV"
  type        = "string"
  default     = "XYZ"
}


variable "lob" {
  description = "ASV"
  type        = "string"
  default     = "COAF"
}

variable "appname" {
  description = "Application Name"
  type        = "string"
  default     = "SQL"
}

variable "owner" {
  description = "Application Owner"
  type        = "string"
  default     = "fmr782"
}

variable "uptime" {
  description = "Uptime"
  type        = "string"
  default     = "excluded"
}


variable "owner_email" {
  description = "Application Owner"
  type        = "string"
  default     = "raman.gupta@capitalone.com"
}

variable "valuestream" {
  description = "Value Stream"
  type        = "string"
  default     = "COAF DATA"
}

variable "additional_tags" {
  description = "Additional AWS tags to be applied to the created resources."
  type = "map"
  default = {}
}


