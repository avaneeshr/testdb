#-----------------------------------------------------------------
# Outputs from the IAM role module
#-----------------------------------------------------------------

output "role_name" {
  value = "${local.current_region == local.default_region 
	? join(",", aws_iam_role.role.*.name) : local.role_name}"
}

output "role_arn" {
  value = "${local.current_region == local.default_region 
	? join(",", aws_iam_role.role.*.arn) : "arn:aws:iam::${local.current_aid}:role/${local.role_name}"}"
}
