#-----------------------------------------------------------------
# Outputs from the envcode module
#-----------------------------------------------------------------

output "envcode" {
  description = "Return the environment code mapped to the current account ID"
  value       = "${local.aid[data.aws_caller_identity.current.account_id]}"
}

output "regcode" {
  description = "Return the region code mapped to the current region"
  value       = "${local.reg[data.aws_region.current.name]}"
}

output "aidlist" {
  description = "Return the list of account IDs "
  value       = "${keys(local.aid)}"
  sensitive   = true
}

output "regionlist" {
  description = "Return the list of region names"
  value       = "${keys(local.reg)}"
  sensitive   = true
}

output "aid" {
  description = "Return the corresponding account ID that matches the input envcode"
  value       = "${lookup(zipmap(values(local.aid), keys(local.aid)), var.envcode)}"
  sensitive   = true
}

output "region" {
  description = "Return the corresponding region that matches the input regcode"
  value       = "${lookup(zipmap(values(local.reg), keys(local.reg)), var.regcode)}"
}

output "envcodemap" {
  description = "Return the map of environment code to account ID as key/value pair"
  value       = "${zipmap(values(local.aid), keys(local.aid))}"
  sensitive   = true
}

output "regcodemap" {
  description = "Return the map of region code to region name as key/value pair"
  value       = "${zipmap(values(local.reg), keys(local.reg))}"
  sensitive   = true
}