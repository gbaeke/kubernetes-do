# kubernetes-do
Kubernetes on DigitalOcean with Terraform

Obtain a DigitalOcean PAT and set an environment variable
- export DO_PAT=Your_DigitalOcean_PAT


terraform init

terraform plan -var "do_token=${DO_PAT}"

terraform apply -var "do_token=${DO_PAT}"
