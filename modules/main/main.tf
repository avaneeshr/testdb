// @Author: Avaneesh Ramprasad (avaner@amazon.com)
// @Date:   2018-09-20
// @Email:  avaner@amazon.com
// @Filename: main.tf
// @Last modified by:   avaner@amazon.com
// @Last modified time:
// Notes:

module "envcode" {
  source = "../environments"
}

data "terraform_remote_state" "coaf" {
  backend = "s3"

  config {
    bucket  = "tf-state-coaf"
    key     = "pipeline/aws-tf-proj-coafs-${module.envcode.envcode}.tfstate"
    region  = "us-east-1"
    profile = "dev"
  }
}

data "template_file" "user_data" {
  template = "${file("${path.cwd}/scripts/userdata.tpl")}"

  vars {
    name        = "test"
    environment = "default"
    run_list    = "nginx"
  }
}

module "ec2" {
  source = "../../modules/compute/ec2"

  instance_count     = "${var.instance_count}"
  ami_id             = "${var.ami_id}"
  instance_type      = "${var.instance_type}"
  instance_name      = "${var.instance_name}"
  user_data          = "${data.template_file.user_data.rendered}"
  security_group_ids = "${var.security_group_ids}"
  subnet_id          = "${var.subnet_ids}"
  key_name           = "${var.key_name}"
  ebs_count          = "${var.ebs_count}"
  ebs_sizes          = "${var.ebs_sizes}"
  ebs_types          = "${var.ebs_types}"
  root_disk_size     = "${var.root_disk_size}"
}

module "lambda-role" {
  source            = "../../modules/security/service-role"
  service           = "lambda.amazonaws.com"
  role_purpose      = "lambda"
  policy_purpose    = "ec2"
  sid_list          = ["1","2","3","4","5","6","7","8"]
  effect_list       = ["Allow","Allow","Allow","Allow","Allow","Allow","Allow","Allow"]
  actions_list      = ["iam:Get*", "ec2:ResetSnapshotAttribute","ec2:ModifySnapshotAttribute", "ec2:DeregisterImage", "ec2:DeleteSnapshot", "ec2:CreateTags","ec2:CreateSnapshot","ec2:CreateImage"]
  resources_list    = ["*"]
  inline_policy     = true
  sid_list          = ["9","10","11"]
  effect_list       = ["Allow","Allow","Allow"]
  actions_list      = ["logs:CreateLogStream", "logs:CreateLogStream","logs:PutLogEvents"]
  resources_list    = ["*"]
  inline_policy     = true

}
