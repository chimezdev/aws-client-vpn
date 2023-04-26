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

# Provision AWS Client VPN
## Client Authentication 
This is needed to determine if a client is permitted to connect to the client VPN endpoint. There 3 ways to authenticate. 
See the link for more on client auth. [Client Authentication](https://docs.aws.amazon.com/vpn/latest/clientvpn-admin/client-authentication.html#mutual)
We will use *Mutual authentiction(certificate-based)
## Use OpenVPN easy-rsa to generate the server and client certificates and keys, and upload the server certificate and key to ACM
- follow the step in this link to generate the certificates and uplode to ACM. [Generate Certificates](https://docs.aws.amazon.com/vpn/latest/clientvpn-admin/client-authentication.html#mutual)
- Copy the certificate arn that will be returned at the end of the steps. You will need it to create the client vpn.