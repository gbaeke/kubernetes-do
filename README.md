# kubernetes-do
Kubernetes on DigitalOcean with Terraform

export DO_PAT=Your_DigitalOcean_PAT

terraform init

terraform plan -var "do_token=${DO_PAT}"

terraform apply -var "do_token=${DO_PAT}"
