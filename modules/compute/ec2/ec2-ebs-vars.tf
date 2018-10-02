#--------------------------------------------
# EC2 EBS Variables
# ec2-ebs-vars.tf
#--------------------------------------------

variable "ebs_count" {
  description = "Number of additional EBS volumes to attach to each instance"
  default     = 0
}

variable "ebs_sizes" {
  description = "A list of EBS sizes, each item in the list cooresponds to an EBS volume in 'ebs_count'. Therefore, if 'ebs_count' = 3, then this list must have 3 items."
  type        = "list"
  default     = [80,100,150,200,300,500]

  # https://www.terraform.io/docs/providers/aws/r/ebs_volume.html#size
}

variable "ebs_types" {
  description = "A list of EBS types, each item in the list cooresponds to an EBS volume in 'ebs_count'. Therefore, if 'ebs_count' = 3, then this list must have 3 items."
  type        = "list"
  default     = ["gp2","io1","sc1","st1"]

  # https://www.terraform.io/docs/providers/aws/r/ebs_volume.html#type
}

variable "snapshot_ids" {
  type        = "list"
  description = "A list of snapshots to base off of, for each EBS volume in 'ebs_count'. Therefore, if 'ebs_count' = 3, then this list must have 3 items."
  default     = [""]

  # https://www.terraform.io/docs/providers/aws/r/ebs_volume.html#snapshot_id
}

variable "ebs_optimized" {
  description = "If true, the launched EC2 instance will be EBS-optimized"
  default     = false

  # https://www.terraform.io/docs/providers/aws/r/instance.html#ebs_optimized
}

variable "root_block_device" {
  description = "Customize details about the root block device of the instance."
  default     = []

  # https://www.terraform.io/docs/providers/aws/r/instance.html#root_block_device
}

variable "ebs_device_names" {
  description = <<EOF
	EBS device names. Predefined so we can automate the naming.
	xvda-xvdj will be reserved so templates can have up to 10 volumes pre-attached.
	Net new EBS volumes will start at xvdf and ends at xvdp (10 volumes)
	EOF

  type    = "list"
  default = ["xvdf","xvdg", "xvdh", "xvdi", "xvdj", "xvdk", "xvdl", "xvdm", "xvdn", "xvdo", "xvdp"]

  # https://www.terraform.io/docs/providers/aws/r/instance.html#ebs_block_device
}

variable "ebs_encryption_key" {
  description = "The ARN for the KMS encryption key that will encrypt EBS volumes."
  default     = ""

  # https://www.terraform.io/docs/providers/aws/r/ebs_volume.html#kms_key_id
}

variable "ebs_block_device_key" {
  description = "Additional EBS block device key to attach to the instance"
  default     = ""
}

variable "ephemeral_block_device" {
  description = "Customize Ephemeral (also known as Instance Store) volumes on the instance."
  default     = []

  # https://www.terraform.io/docs/providers/aws/r/instance.html#ephemeral_block_device
}

variable "force_detach" {
  description = "Set to true if you want to force the volume to detach. Useful if previous attempts failed, but use this option only as a last resort, as this can result in data loss."

  default = false

  # https://www.terraform.io/docs/providers/aws/r/volume_attachment.html#force_detach
}

variable "skip_destroy" {
  description = "Set this to true if you do not wish to detach the volume from the instance to which it is attached at destroy time."

  default = false

  # https://www.terraform.io/docs/providers/aws/r/volume_attachment.html#skip_destroy
}