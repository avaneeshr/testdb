#------------------------------------------------------
# global settings
#------------------------------------------------------
provider "aws" {
  profile = "qa"
  region = "${var.aws_region}"
}

# Lookup the correct AMI based on the region specified
data "aws_ami" "amazon_windows_2012R2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["Windows_Server-2012-R2_RTM-English-64Bit-Base-*"]
  }
}

module "main" {
  source = "../../modules/main"

  #------------------------------------------------------
  #Build Variables
  #------------------------------------------------------


  ami_id                = "${data.aws_ami.amazon_windows_2012R2.id}"
  instance_count        = 1
  instance_type         = "t2.micro"
  security_group_ids    = ["sg-0557578fd88d81fe3","sg-0521045832493a3ed"]
  instance_name         = "${upper(var.lob)}-${upper(var.appname)}-${upper(var.env_name)}"
  key_name              = "EC2KeyPair"
  subnet_ids            = "subnet-07f90729"
  ebs_count             = 2
  ebs_sizes             = [80, 150]
  ebs_types             = ["gp2","gp2"]
  root_disk_size        = "80"
}
