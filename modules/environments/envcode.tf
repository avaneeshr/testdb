
/*
  Author:         Avaneesh Ramprasad
  Email:          avaner@amazon.com
  Creation Date:  09-20-2018
  Why:            IT Infra has a naming standard which uses a 1-character code to represent AWS account ID and a 2-character code to represent AWS region. Using a module to map the account ID / environment code pair and the regoin name / region code pair would ensure all developers use the same coding without the need to search in the naming standard documentation.
  What:           This Terraform module outputs account ID, environment code, region name, region code, account ID list, region name list, envcode/accountId map, and regcode/region name map. 
*/

# Get the account ID and region of current session
data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

locals {
  aid = "${map(
    "282151010629", "dev",
    "2821510106291", "qa",
    "610014150274", "qa2",
    "663734964561", "prod",
  )}"

  reg = "${map(
    "us-west-2",      "or",
    "us-east-1",      "va",
  )}"
}