variable "aws_region" {
  description = "The AWS region to build network infrastructure"
  type        = "string"
  default     = "us-east-1"
}

variable "offset" {
  description = "Set to change the avalibility zone offset of the VPC. (e.g. a value of 0 would deploy us-east-1a b and c. A value of 1 would deploy to b c and d"
  type        = "string"
  default     = "0"
}

variable "additional_tags" {
  description = "Additional  AWS tags to be applied to the created resources."
  type        = "map"
  default     = {}
}

variable "ami_id" {
  type        = "string"
  description = "The AMI to use for the instance. This overwrites the Auto find AMI filter"
  default = "ami-04b06bdb58cae787d"

  # https://www.terraform.io/docs/providers/aws/r/instance.html#ami
}

variable "instance_count" {
  default     = 1
  description = "Number of instances"
}

variable "starting_number" {
  default     = 0
  description = "The number that will be part of the hostname. If 'instance_count' is more than 1, then each instance' hostname will include a number that starts with 'starting_number'."
}

variable "instance_type" {
  type        = "string"
  description = "Instance type to start"
  default = "t2.micro"

  # https://www.terraform.io/docs/providers/aws/r/instance.html#instance_type
}

variable "instance_name" {
  type        = "string"
  description = "Name of the EC2 instance"
  default = "DEV"
}
variable "root_disk_size" {
  type        = "string"
  description = "Size of the root volume"

}
variable "key_name" {
  type        = "string"
  description = "Name of the AWS SSH key to use"
  default = "EC2KeyPair"
  # https://www.terraform.io/docs/providers/aws/r/instance.html#key_name
}

variable "disable_api_termination" {
  description = "If true, enables EC2 Instance Termination Protection"
  default     = false

  # https://www.terraform.io/docs/providers/aws/r/instance.html#disable_api_termination
}


variable "security_group_ids" {
  type        = "list"
  description = "security group id from sg module"
  default     = []

  # https://www.terraform.io/docs/providers/aws/r/instance.html#vpc_security_group_ids
}

variable "subnet_ids" {
  description = "Subnet Id"
  default     = ""
}

variable "ebs_count" {
  description = "Number of additional EBS volumes to attach to each instance"
  default     = 0
}

variable "ebs_sizes" {
  description = "A list of EBS sizes, each item in the list cooresponds to an EBS volume in 'ebs_count'. Therefore, if 'ebs_count' = 3, then this list must have 3 items."
  type        = "list"
  default     = []

  # https://www.terraform.io/docs/providers/aws/r/ebs_volume.html#size
}

variable "ebs_types" {
  description = "A list of EBS types, each item in the list cooresponds to an EBS volume in 'ebs_count'. Therefore, if 'ebs_count' = 3, then this list must have 3 items."
  type        = "list"
  default     = []

  # https://www.terraform.io/docs/providers/aws/r/ebs_volume.html#type
}


variable "role" {
  description = "Role"
  type        = "string"
  default     = "db"
}

variable "lob" {
  description = "Role"
  type        = "string"
  default     = "COAF-xx"
}


variable "asv" {
  description = "ASV"
  type        = "string"
  default     = "XYZ"
}
variable "appname" {
  description = "Application Name"
  type        = "string"
  default     = "DB"
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

variable "value_stream" {
  description = "Value Stream"
  type        = "string"
  default     = "COAF DATA"
}

variable "instance_username" {
  type        = "string"
  description = "Instance Username"
  default = ""
}

variable "instance_password" {
  type        = "string"
  description = "Instance password"
  default = ""
}
