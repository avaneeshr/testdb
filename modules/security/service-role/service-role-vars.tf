#-----------------------------------------------------------------
# Input variables for the IAM role module
#-----------------------------------------------------------------

variable "default_region" {
  description = "The AWS region that should create the IAM resources"
  default     = "us-east-1"
}

variable "service" {
  description = "The AWS service's name in 'x.amazonaws.com' format. Reference the full list of AWS services at: https://docs.aws.amazon.com/general/latest/gr/aws-arns-and-namespaces.html#genref-aws-service-namespaces"
  type        = "string"
}

variable "role_purpose" {
  description = "Short description of the role. This value will be appended to the role name."
  type        = "string"
}

variable "create" {
  default     = true
  description = "When this module is included another module, you may not want it to run every time the other module is executed, use this variable to turn off this module."
}

#-----------------------------------------------------------------
# Input variables for inline policy attached to the role
#-----------------------------------------------------------------

variable "inline_policy" {
  description = "Whether to attach an inline policy to the role. Allowed values are true or false. Default vaule is false."
  default     = false
}

variable "policy_purpose" {
  description = "short description of the policy. "
  type        = "string"
  default     = ""
}

variable "sid_list" {
  description = "A list of statement IDs for insert into the 'Statement' element of the IAM policy. Each item in the 'sid-list', will create a separate statement in the IAM policy."
  type        = "list"
  default     = []
}

variable "effect_list" {
  description = "A list of effects for insert into the 'Effect' element of the IAM policy. Each item in the 'effect-list' cooresponds to an item in the 'sid-list', thereby, will be inserted into a separate statement in the IAM policy."
  type        = "list"
  default     = []
}

variable "actions_list" {
  description = "A list of actions for insert into the 'Action' element of the IAM policy. Each item in the 'actions-list' cooresponds to an item in the 'sid-list', thereby, will be inserted into a separate statement in the IAM policy. Each item in the 'actions-list' can be a string of action elements, with comma deliminator. For example, one item can be a string of 'ec2:Delete*,ec2:Describe*,ec2:Create*'. Don't leave any space between commas."
  type        = "list"
  default     = []
}

variable "resources_list" {
  description = "A list of resources for insert into the 'Resource' element of the IAM policy. Each item in the 'resources-list' cooresponds to an item in the 'sid-list', thereby, will be inserted into a separate statement in the IAM policy. Each item in the 'resources-list' can be a string of action elements, with comma deliminator. For example, one item can be a string of '*, arn:aws:ec2:*'. Don't leave any space between commas."
  type        = "list"
  default     = []
}

#-----------------------------------------------------------------
# Input variables for managed policy attached to the role
#-----------------------------------------------------------------

variable "managed_policy" {
  description = "Whether to attach managed policies to the role. Allowed values are true or false. Default vaule is false."
  default     = false
}

# The module uses 'count.index' to iterate the items in this list. Because of that, Terraform requires this list to be NOT empty so we use "ReadOnlyAccess" as a default value
variable "policy_arn_list" {
  description = "A list of IAM policy ARNs from existing managed policies. Each item in the list will be a managed policy attached to the role."
  default     = ["arn:aws:iam::aws:policy/ReadOnlyAccess"]
}