#------------------------------------------------------
# global settings
#------------------------------------------------------
provider "aws" {
  profile = "dev"
  region  = "${var.aws_region}"
}

# Lookup the correct AMI based on the region specified
data "aws_ami" "amazon_windows_2012R2" {
  most_recent = true
  owners      = ["282151010629"]

  filter {
    name   = "name"
    values = ["${var.ami_name}*"]
  }
}

module "main" {
  source = "../../modules/main"

  #------------------------------------------------------
  #Build Variables
  #------------------------------------------------------

  ami_id             = "${data.aws_ami.amazon_windows_2012R2.id}"
  instance_count     = 1
  instance_type      = "t2.micro"
  security_group_ids = ["sg-0557578fd88d81fe3", "sg-0521045832493a3ed"]
  instance_name      = "${upper(var.lob)}-${upper(var.appname)}-${upper(var.env_name)}"
  key_name           = "EC2KeyPair"
  subnet_ids         = "${var.subnet_id}"
  # ebs_count          = 1
  #ebs_sizes          = [80]
  #ebs_types          = ["gp2"]
  root_disk_size = "50"
}

