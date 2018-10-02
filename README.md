#  SQL Sever

This module will provision a windows 2016 EC2 instance with SQL Server 2016 in AWS using terraform. 

[![Arch Diagram]]

## Dependencies

- **Terraform**: Terraform 

## Getting Started

#### Configure local backend:

**backend.tf**: To set up a terraform backend create a copy of backend.tf.example.

```bash
cp backend.tf.example backend.tf
```

Edit backend.tf and change BUCKET_NAME and S3_KEY to desired values.

```hcl-terraform
terraform {
  backend "s3" {
    bucket = "my-s3-bucket"
    key    = "my-terraform-statefile"
    region = "us-east-1"
  }
}
```

#### Local AWS Credentials:

Terraform does not read from your AWS credential file. You'll need to set environment variables for API keys.

```bash
export AWS_ACCESS_KEY_ID=AKIA#############
export AWS_SECRET_ACCESS_KEY=ir+c#########################
export AWS_SESSION_TOKEN=wEa#########################
```

#### First initialization:

To test if your configuration is working.

```bash
./build.sh init
```

#### SSM Parameters:

Finally you will need to set up SSM parameters. All parameters should be imported in `ssm_variables.tf`. Here is an example of how to create those parameters:

```bash
aws ssm put-parameter --name "PUBLIC_KEY" --value "$(cat ~/.ssh/id_rsa.pub)" --type SecureString
```

**Note**: these examples are relative to your current working directory

## Terraform in Docker

To build and push a new Terraform Docker container use the build.sh script.

```bash
./build.sh build
./build.sh push
```

If you are making changes to the terraform Dockerfile, you may wish to use a test repo. You can change the default repository by setting the REPO_NAME environment variables.

```bash
export REPO_NAME=(account_number).dkr.ecr.us-east-1.amazonaws.com/terraform_test
```

#### Running terraform:

You should now be able to build a Kubernetes cluster with EKS.

```bash
./build.sh apply
```

## Continuous Delivery Instructions

The project is designed to work in AWS CodeBuild by default but can be used with Jenkins as well. To enable builds, create a new CodeBuild project. For the most part CodeBuild project defaults will work.

Point the project at your repository. I suggest keeping the code in either AWS CodeCommit or GitHub. You may need to approve access to your GitHub account within the console.

I also suggest setting a branch filter (most likely master) so pushes to other branches do not overwrite your cluster(s).

For current image we suggest aws/codebuild/docker. You can use a custom image, but Docker is required to be installed on that image.

The following environment variables are used by the build.

| Variable | Required | Type | Description |
|----------|----------|------|-------------|
| AWS_SECRET_ACCESS_KEY | Y | Parameter Store | AWS Secret Access key the build will use to access AWS resources. |
| AWS_ACCESS_KEY_ID | Y | Parameter Store | AWS Access key ID |
| REPO_NAME | N | Plaintext | Docker repository where the Terraform container resides |
| BUCKET_NAME | Y | Plaintext | S3 bucket to store Terraform state |
| S3_KEY | Y | Plaintext | S3 key to store Terraform state |

## Modules

### SQL Server 2016

This module will create the following:



Click [**Here**](Variables.md#) to review the inputs

