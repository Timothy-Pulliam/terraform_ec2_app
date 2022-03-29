tfvars_file=$1

# Check if tfvars file exists
if [[ ! -e "${tfvars_file}" ]]; then
  echo "Could not locate tfvars file: ${tfvars_file}. Specify the proper location, exiting..."
  exit 1
fi

terraform init
terraform plan -detailed-exitcode -parallelism=20 -refresh=true -var-file="${tfvars_file}" -out=plan.out || true
