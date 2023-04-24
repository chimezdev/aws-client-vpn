# AWS Client VPN Provisioning with Terraform

## Configure your cli
- run `aws configure --profile default` and provide your aws credentials such as ***access_key*** and ***secret_access_key***

## Provision backend resources
- Use a local backend to create resources
    - create the **backend.tf**, **main.tf**, **variables.tf**, **output.tf** and **README.tf** files and copy the respective starter codes into them
    - run `terraform init` to initialize terraform to use a local backend.
    - run `terraform plan` and `terraform apply` to create the resources.
    - after the resources have been provisioned, copy the respective outputs to the corresponding values in the **backend** block in the **backend.tf** file

- Migrate the terraform state to s3
    - uncommet the *terraform* block of the **backend.tf** file
    - run `terraform init` again and follow the prompt to migrate the terraform state to s3 that we have provisioned.

## Commit your changes
- Before you commit your code to a version control system such as git, ensure to add the ***.terraform and terraform*** files to a ***.gitinore*** file