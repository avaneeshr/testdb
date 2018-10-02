#--------------------------------------------
# EC2 Instance Variables and Placement Group
# ec2-vars.tf
#--------------------------------------------

# variable "name" {
#   type        = "string"
#   description = "Name of instances"
# }

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

  # https://www.terraform.io/docs/providers/aws/r/instance.html#instance_type
}

variable "instance_name" {
  type        = "string"
  description = "Name of the EC2 instance"

}

variable "root_disk_size" {
  type        = "string"
  description = "Size of the root volume"

}
variable "key_name" {
  type        = "string"
  description = "Name of the AWS SSH key to use"

  # https://www.terraform.io/docs/providers/aws/r/instance.html#key_name
}

variable "disable_api_termination" {
  description = "If true, enables EC2 Instance Termination Protection"
  default     = false

  # https://www.terraform.io/docs/providers/aws/r/instance.html#disable_api_termination
}

variable "shutdown_behavior" {
  description = "Shutdown behavior for the instance. stop or terminate"
  default     = "stop"

  # https://www.terraform.io/docs/providers/aws/r/instance.html#instance_initiated_shutdown_behavior
}

variable "monitoring" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  default     = false

  # https://www.terraform.io/docs/providers/aws/r/instance.html#monitoring
}

variable "tenancy" {
  description = "The tenancy of the instance (if the instance is running in a VPC). Available values: default, dedicated, host."
  default     = "default"

  # https://www.terraform.io/docs/providers/aws/r/instance.html#tenancy
}

variable "user_data" {
  description = "The user data to provide when launching the instance"
  default     = ""

  # https://www.terraform.io/docs/providers/aws/r/instance.html#user_data
}

variable "iam_instance_profile" {
  description = "The IAM Instance Profile to launch the instance with. Specified as the name of the Instance Profile."
  default     = ""

  # https://www.terraform.io/docs/providers/aws/r/instance.html#iam_instance_profile
}

#--------------------------------------------
# EC2 Placement Group
#--------------------------------------------

variable "placement_group" {
  description = "The Placement Group to start the instance in"
  default     = ""

  # https://www.terraform.io/docs/providers/aws/r/instance.html#placement_group
}

variable "security_group_ids" {
  type        = "list"
  description = "security group id from sg module"
  default     = []

  # https://www.terraform.io/docs/providers/aws/r/instance.html#vpc_security_group_ids
}

variable "subnet_id" {
  description = "Subnet Id"
  default     = ""

}
variable "subnet_type" {
  description = "Subnet type. Value can be either 'private' or 'private-static'."
  default     = "private"
}

variable "private_ip" {
  description = "Private IP address to associate with the instance in a VPC"
  default     = ""

  # https://www.terraform.io/docs/providers/aws/r/instance.html#private_ip
}

variable "source_dest_check" {
  description = "Controls if traffic is routed to the instance when the destination address does not match the instance. Used for NAT or VPNs."
  default     = true

  # https://www.terraform.io/docs/providers/aws/r/instance.html#source_dest_check
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
