# Variables

## Main

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | -------- |
| aws_region | The AWS region to deploy the EKS cluster | string | - | Y |
| additional_tags | Any additional tags that need to be included | map | {} | N |
| config_output_path | Local path to output configuration files | string | .terraform | N |

## SQL Server

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | -------- |
| aws_region | The AWS region to deploy the EKS cluster | string | us-east-1 | Y |
| aws_az_number | The number of AZ's that will be used | string | 3 | N |
| subnet_ids | AWS Subnet Ids  | list | [] | Y |
| iam_role | IAM Role assigned to the instance | string | xx-COAF-xx-CustomRole-xx | Y |
| sns_topic | ARN of the SNS topic | string | arn:aws:sns:us-east-1:995719991135:COAF | Y |
| ent_sns_topic | ARN of the Enterprise SNS topic | string | arn:aws:sns:us-east-1:995719991135:COAF | Y |
| security_groups | List of security groups | list | [] |Y |
| keyname | EC2 Key Pair name | string | xx-COAF-xx-CustomRole-xx | Y |
| s3_bucket | Name of the S3 bucket | string | coafwind | Y |
| image_id | AMI ID for creating the EC2 instance | string | ami-4bad0234 | Y |
| ebs_snapshot | EBS Snapshot id  | string | snap-02587edfb5c5c7e8 | Y |
| ebs_optimized | Is instance EBS optimized | string | true | N |
| user_data |  Userdata for the EC2 instance| string | - | Y |
| asv | ASV | string | XYZ | Y |
| lob | Line of Business | string | COAF-xx | Y |
| appname | Application Name | string | SQL | Y |
| role | Role | string | DB | Y |
| owner | Owner | string | fmr782 | Y |
| valuestream | Value Stream | string | COAF DATA | Y |
| uptime | Indicates if the server needs to running or shutdown | string  | excluded | Y |
| owner_email | Owner email address | string | raman.gupta@capitalone.com | Y |
| additional_tags | Any additional tags that need to be included | map | {} | N |
