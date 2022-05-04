# TA
IaC:
Declarative vs imperative languages, idempotent, configuration drift
Provisionning, Deployment, Orchestration
Gitops methodology: detect congif drift, correct config drift, prevent config drift, mutable vs immutable infrastructure


Terraform Lifecycle:
Code --> init --> plan --> validate --> apply --> destroy

Resource Graph: dependency graph

## 0:
Kubernetes: I used Kubernetes function of Docker Desktop Application and followed a little bit this tutorial: https://learn.hashicorp.com/tutorials/terraform/kubernetes-provider

AWS: I followed this : https://learn.hashicorp.com/collections/terraform/aws-get-started

```bash
kubectl config view --minify --flatten --context=docker-desktop
terraform init 
terraform fmt
terraform validate 
terraform plan
terraform plan -var instance_ami="ami-0ebc281c20e89ba4b"
terraform apply
ter2raform show
terraform state list
terraform output
terraform destroy --auto-approve
```

```bash
terraform login
```

## 1 - Providers:
Providers: Kubernetes, AWS, docker GCP, ... 
required_providers (source, version, configuration_aliases ), ``` [<HOSTNAME>/]<NAMESPACE>/<TYPE> ``` defined in root module
provider ( alias, ~~version~~)  

## 2 - State:
terraform.tfstate, terraform.tfstate.backup
Performance: ``` terraform plan -refresh=false -target=main.tf ```
```
terraform state pull
terraform state push
```

## 3 - Terraform settings
backend ( Terraform cloud, NFS, S3, ...)
required_version
required_providers

## 4 - Provision
cloud_init
Packer
Provisioners ( run in creation-time/ destroy-time): shell, ansible, local-exec, ...
