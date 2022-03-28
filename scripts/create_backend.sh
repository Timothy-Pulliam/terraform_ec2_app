# Host terraform.tfstate file in S3 bucket
aws s3 mb s3://$1 

# remote state file locking with DynamoDB
#aws dynamodb create-table --table-name tfm-state-lock --key-schema 