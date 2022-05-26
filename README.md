# TA: Preparing for Terraform Associate Exam
IaC:
Declarative vs imperative languages, idempotent, configuration drift<br />
Provisionning, Deployment, Orchestration <br />
Gitops methodology: detect config drift, correct config drift, prevent config drift, mutable vs immutable infrastructure <br />


Terraform Lifecycle:
Code --> fmt --> init  --> validate --> plan--> apply  --> validate  --> plan --> apply --> destroy <br />

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
terraform taint ws_security_group.sg_8080 # (deprecated) force terraform to replace the resource next apply
terraform force-unlock # manually unlock the state if automatic unlock failed
```

### Syntax:
collections(map, list, set), object, tupple.<br />
Functions: numeric ( abs, floor, log, max, ...), string( chmop, indent, join, split, upper, ...), collection ( concat, contains, distinct, , ...), encoding (jsonencode, yamldecode, csvencode, ...), filesystem (abspath, file, ...), date, hash, network, type conversion, ... <br />
conditional expression: ```(var.name != "" ? var.name : "default_value") ``` <br />
Dynamic blocks using ```dynamic``` and ``` for_each ``` <br />
 
## 1 - Providers:
Providers: Kubernetes, AWS, docker GCP, ... <br />
required_providers (source, version, configuration_aliases ), ``` [<HOSTNAME>/]<NAMESPACE>/<TYPE> ``` defined in root module <br />
provider ( alias, ~~version~~) <br />
Kubernetes: I used Kubernetes function of Docker Desktop Application and followed a little bit this tutorial: https://learn.hashicorp.com/tutorials/terraform/kubernetes-provider
```bash
kubectl config view --minify --flatten --context=docker-desktop
```
AWS: I followed this tutorial: https://learn.hashicorp.com/collections/terraform/aws-get-started 

## 2 - State:
terraform.tfstate, terraform.tfstate.backup <br />
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
backend ( Terraform cloud, NFS, S3, ...) <br />
required_version <br />
required_providers <br />
resources, dependencies <br />
## 4 - Provision
cloud_init <br />
Packer <br />
Provisioners ( run in creation-time/ destroy-time ): shell, ansible, puppet, file, local-exec, remote_exec ... <br />
## 5 - Dependencies
Providers ( version, constraints, hashes ) & modules <br />
lock file: ```.terraform.lock.hcl``` ( updated whenever  ```terraform init ``` runs) <br />
```bash
terraform init -upgrade # force use of configured dependencies versions ( discard lock file details )
```
```depends_on``` meta data: create dependencies between resources
```
terraform graph | dot -Tsvg > graph.svg # display a graph of dependency between resources, providers, ... <br />
```
## 6 - Workspace
```bash
terraform workspace show # displays current workspace
terraform workspace new devel # creates new workspace and switch to it ( creates terraform.tfstate.d/devel directory )
terraform workspace select mydevworkspace # switch to a workspace
terraform workspace list # list existing workspaces
```
## 7 - Organization
Project Structure: devide folders per environment ( dev, test, prod ...) <br />
## 8 - Workflow
### Import existant resources
- Initialize empty corresponding resource <br />
- Import resource definition to state: <br />
```bash
terraform import docker_container.web $(docker inspect --format="{{.ID}}" hashicorp-learn) # import a running container
```
- check import: check in tfstate file, show resource config, add config to a tf file <br />
```bash
vim terraform.tfstate 
terraform show 
terraform show --no-color >> docker.tf
```
- remove depricated, unconfigurable parametters
```bash
terraform plan
```
- make config persistent
```bash
terraform apply
```
# 9 - Modules:
Follow responsibility segregation <br />
Minimum viable Product (MVP) <br />
Nested modules <br />
Document modules ( required inputs, optional inputs, outputs), add .gitignore, add README, semantic versionning. <br />
Publish module: public github repo, name, description, structure, tags for release. <br />

# 11 - Terraform Cloud  Enterprise
```bash
terraform login
```
Terraform runs workflow: UI/VSC driven, API driven, CLI driven <br />
Sentinel: CLI, policies, policy-as-code