#!/usr/bin/env bash

# Pin version of Terraform
VERSION_TAG=0.11.8

# Detect and change configurations based on TTY (Detecting CI)
if [ -t 1 ]; then
    export TTY=-it
else
    export AUTOAPPROVE=-auto-approve
    if [ ! -f backend.tf ]; then
        cp backend.tf.example backend.tf
        sed -i s,BUCKET_NAME,${BUCKET_NAME},g backend.tf
        sed -i s,S3_KEY,${S3_KEY},g backend.tf
    fi
fi

# If repo value is not set, use a default
if [ -z ${REPO_NAME+x} ]; then REPO_NAME=282151010629.dkr.ecr.us-east-1.amazonaws.com/terraform; fi

# Log into ECR
$(aws ecr get-login --no-include-email)

# Wrap the docker Terraform function
terraform_func(){
    echo "value of $1 and $2 and $3 and $4"
    docker run                                          \
      --rm                                              \
      -w /workspace/envs/dev                            \
      -v $(pwd):/workspace                              \
      -v $(pwd):/workspace/.terraform                   \
      -e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID}         \
      -e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
      -e AWS_SESSION_TOKEN=${AWS_SESSION_TOKEN}         \
      -e TF_VAR_offset=${TF_VAR_offset}                 \
      ${TTY}                                            \
      ${REPO_NAME}:${VERSION_TAG}                       \
        terraform $1 $2 
}

init(){
    terraform_func init
}

plan(){
    terraform_func plan
}

apply(){
    terraform_func apply ${AUTOAPPROVE}
}

destroy(){
    terraform_func destroy ${AUTOAPPROVE}
}

refresh(){
    terraform_func refresh
}

version(){
    terraform_func version
}

build(){
    docker build --build-arg TERRAFORM_VERSION=${VERSION_TAG} -t ${REPO_NAME}:${VERSION_TAG} .
}

push(){
    docker push ${REPO_NAME}:${VERSION_TAG}
}

case "$1" in
        init)
                init
                ;;
        plan)
                plan
                ;;
        apply)
                apply
                ;;
        destroy)
                destroy
		        ;;
        refresh)
                refresh
		        ;;
        version)
                version
                ;;
        build)
                build
                ;;
        push)
                push
                ;;
        *)
                echo $"Usage: $0 {init|plan|apply|destroy|refresh|version|build|push}"
esac