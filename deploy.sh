#!/bin/sh

echo "Hello I am ruiinh"

STAGE_NAME="dev"
BUCKET="pet-store-api-deployment-workspace-$STAGE_NAME"
STACK_NAME=todo-app-$STAGE_NAME

# Creates your deployment bucket if it doesn't exist yet.

echo "Creating a bucket $BUCKET"
aws s3 mb s3://$BUCKET
aws s3 cp swagger.yaml s3://$BUCKET/swagger.yaml

# Uploads files to S3 bucket and creates CloudFormation template
sam.cmd package \
    --template-file template.yaml \
    --s3-bucket $BUCKET \
    --output-template-file package.yaml


# Deploys your stack
sam.cmd deploy --template-file package.yaml \
    --stack-name pet-store-stack \
    --parameter-overrides StageName=$STAGE_NAME S3BucketName=$BUCKET \
    --capabilities CAPABILITY_IAM

read -p "Press enter to continue"
