# TA
IaC:
Declarative vs imperative languages, idempotent, configuration drift
Provisionning, Deployment, Orchestration
Gitops methodology: detect congif drift, correct config drift, prevent config drift, mutable vs immutable infrastructure


Terraform Lifecycle:
Code --> init --> plan --> validate --> apply --> destroy

Resource Graph: dependency graph

## 0: General
```bash
kubectl config view --minify --flatten --context=docker-desktop
terraform fmt -diff -recursive # check syntax, lint code ( display modifications )
terraform init 
terraform validate # validate resources, dependencies, ...
terraform plan
terraform plan -var instance_ami="ami-0ebc281c20e89ba4b" # plan with input var 
terraform apply
terraform show
terraform state list
terraform output
terraform destroy --auto-approve
terraform plan -replace; terraform apply -replace # recreate only modified resources
```

```bash
terraform login
```

## 1 - Providers:
Providers: Kubernetes, AWS, docker GCP, ... 
required_providers (source, version, configuration_aliases ), ``` [<HOSTNAME>/]<NAMESPACE>/<TYPE> ``` defined in root module
provider ( alias, ~~version~~) 
Kubernetes: I used Kubernetes function of Docker Desktop Application and followed a little bit this tutorial: https://learn.hashicorp.com/tutorials/terraform/kubernetes-provider
```bash
kubectl config view --minify --flatten --context=docker-desktop
``` 
AWS: I followed this tutorial: https://learn.hashicorp.com/collections/terraform/aws-get-started 

## 2 - State:
terraform.tfstate, terraform.tfstate.backup
Performance: ``` terraform plan -refresh=false -target=main.tf ```
```bash
terraform show  # tfstate
terraform state list # list of resources
terraform state pull #  pull state from backend
terraform state push # push tfstate file to backend
terraform refresh # update tfstate file from real world
terraform plan -refresh-only # better than terraform refresh ( more details )
terraform apply -replace="aws_instance.example" # destroy and recreate a resource
terraform state rm aws_security_group.sg_8080 # remove a resource from tfstate file ( will not be destroyed or removed from config)
terraform import # import resource definition 
```
```bash
terraform plan -target="random_pet.bucket_name" # trget one resource
terraform apply -target="random_pet.bucket_name" # target update on one resource
```
```bash
# move resource from one tfstate file to another
terraform state list
terraform state mv -state-out=../terraform.tfstate aws_instance.example_new aws_instance.example_new
```
troubleshoot:
```bash
export TF_LOG_CORE=TRACE
export TF_LOG_PROVIDER=TRACE
export TF_LOG_PATH=logs.txt
```
Drift:
```bash
terraform plan -refresh-only # detect changes done outside 
terraform apply -refresh-only # correct drift ( safer than terraform apply  )

```
Lifecycle of resources: prevent_destroy, create_before_destroy, ignore_changes

```bash
terraform output -json bucket_details # display an output variable in json format
terraform console # start terraform console
    jsonencode({ id = aws_s3_bucket.data.id, region = aws_s3_bucket.data.region })  # function to encode json
    jsondecode(file("bucket_policy.json")) # function to read then decode json file to HCL
    chomp(data.http.local_ip.body) # funtion to clean whitespaces
```
moved: used in configuration to move resources, modules already created
## 3 - Terraform settings
backend ( Terraform cloud, NFS, S3, ...)
required_version
required_providers
resources, dependencies
## 4 - Provision
cloud_init
Packer
Provisioners ( run in creation-time/ destroy-time ): shell, ansible, local-exec, ...
## 5 - Dependencies
Providers ( version, constraints, hashes ) & modules
lock file: ```.terraform.lock.hcl``` ( updated whenever  ```terraform init ``` runs)
```bash
terraform init -upgrade # force use of configured dependencies versions ( discard lock file details )
```
