# kubernetes-do
Kubernetes on DigitalOcean with Terraform

Obtain a DigitalOcean PAT and set an environment variable:
- export DO_PAT=Your_DigitalOcean_PAT

Make sure terraform is installend and run:
- terraform init

Run terraform plan first:
- terraform plan -var "do_token=${DO_PAT}"

Now start the deployment:
- terraform apply -var "do_token=${DO_PAT}"

**Note:** do_token is a variable defined in provider.tf
