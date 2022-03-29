#! /usr/bin/sh
bucket_name=$1

# Host terraform.tfstate file in S3 bucket
aws s3 mb s3://${bucket_name}
aws s3api put-bucket-versioning --bucket ${bucket_name} --versioning-configuration Status=Enabled
aws s3api put-bucket-encryption \
    --bucket ${bucket_name} \
    --server-side-encryption-configuration '{"Rules": [{"ApplyServerSideEncryptionByDefault": {"SSEAlgorithm": "AES256"}}]}'

# remote state file locking with DynamoDB
# parent path = ${0%/*}
aws dynamodb create-table --cli-input-json file://${0%/*}/create-table.json
