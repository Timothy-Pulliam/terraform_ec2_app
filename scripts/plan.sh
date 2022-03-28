tfvars_file=$1

terraform init
terraform plan -detailed-exitcode -parallelism=20 -refresh=true -var-file="${tfvars_file}" -out=plan.out || true
