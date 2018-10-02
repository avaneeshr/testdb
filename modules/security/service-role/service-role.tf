/*
	Author:				Avaneesh Ramprasad
	Email:				avaner@amazon.com    
    Why:				This creates an IAM role that a AWS service can assume
	What:				This tf file is the main module to setup a IAM role. This service role can
							have an inline policy or have multiple managed policies attached.
*/

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

locals {
  default_region = "${var.default_region}"
  current_aid    = "${data.aws_caller_identity.current.account_id}"
  current_region = "${data.aws_region.current.name}"

  # The conditional statement in the 'resource' component of this code makes the 'output' 
  # component of this code difficult.  To garantee we can output, even if the resource is not
  # created, we use the following 'local' variables in the 'output' component.

  role_name   = "${var.role_purpose}-service-role"
  policy_name = "${var.policy_purpose}-policy"
}

#------------------------------------------------------
# IAM Role Build
#------------------------------------------------------

data "template_file" "trust_policy_doc" {
  count = "${var.create ? 1:0 }"

  template = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [ 
		{
			"Effect": "Allow",
			"Principal": {
				"Service":"$${service}"
			},
			"Action": "sts:AssumeRole"
		}
	]
}
EOF

  vars {
    service = "${var.service}"
  }
}

resource "aws_iam_role" "role" {
  # IAM Role is a global resource, we only need to create this in the default region
  # Having this conditional statement also ensures the resource won't be destroyed if this code is 
  # accidentally executed in a non-default region.
  count = "${(local.current_region == local.default_region) && var.create ? 1:0}"

  name = "${local.role_name}"

  assume_role_policy = <<POLICY
${data.template_file.trust_policy_doc.rendered}
POLICY
}

#------------------------------------------------------
# IAM Inline Policy Build
#------------------------------------------------------

data "template_file" "statements_doc" {
  count = "${var.create ? length(var.sid_list) : 0 }"

  template = <<EOF
{
	"Sid": "$${sid}",
	"Effect": "$${effect}",
	"Action": $${actions},
	"Resource": $${resources}
}
EOF

  vars {
    sid       = "${element(var.sid_list, count.index)}"
    effect    = "${element(var.effect_list, count.index)}"
    actions   = "${jsonencode(split(",", element(var.actions_list, count.index)))}"
    resources = "${jsonencode(split(",", element(var.resources_list, count.index)))}"
  }
}

data "template_file" "policy_doc" {
  count = "${var.create ? 1:0 }"

  template = <<EOF
{
	"Version": "2012-10-17",
	"Statement": [
		$${statements}
	]
}
EOF

  vars {
    statements = "${join(",", data.template_file.statements_doc.*.rendered)}"
  }
}

resource "aws_iam_role_policy" "role_policy" {
  count = "${(local.current_region == local.default_region) 
							&& var.inline_policy && var.create ? 1 : 0}"

  name = "${local.policy_name}"
  role = "${aws_iam_role.role.name}"

  policy = <<POLICY
${data.template_file.policy_doc.rendered}  
POLICY
}

#------------------------------------------------------
# IAM Managed Policy Attachement
#------------------------------------------------------

resource "aws_iam_role_policy_attachment" "role_policy_attach" {
  count = "${(local.current_region == local.default_region) && 
						var.managed_policy && var.create ? length(var.policy_arn_list) : 0}"

  role       = "${aws_iam_role.role.name}"
  policy_arn = "${element(var.policy_arn_list, count.index)}"
}