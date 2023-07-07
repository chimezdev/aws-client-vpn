# AWS Client VPN Provisioning with Terraform
"AWS Client VPN is a managed client-based VPN service that enables you to securely access your AWS resources and resources in your on-premises network. With Client VPN, you can securely access your resources from any location using an OpenVPN-based VPN client including your databases in private subnet. 
This project is to privide guild on how to provision AWS Client VPN using IaC - Terraform
## Configure your AWS cli
To begin with, configure your AWS CLI to be able to authenticate with your AWS account.
- run `aws configure --profile <your_profile_name>` and provide your aws credentials such as ***access_key***, ***secret_access_key***, ***default region*** and output format

## Provision backend resources
"Terraform stores state about managed infrastructure to map real-world resources to the configuration, keep track of metadata, and improve performance. Terraform stores this state in a local file by default, but you can also use a Terraform remote backend to store state remotely. We will use AWS S3 as our remote backend and DynamoDB for state lock but first will use local state to create the S3, KMS key and DynamoDB resources after which we migrate the state file to S3.

- Use a local backend to create resources
    - from your terminal, cd into your project folder and run the command, `touch <file_name.extension>`
    - create the **backend.tf**, **main.tf**, **variables.tf**, **output.tf** and **README.md** files and copy the respective starter codes into them
    - run `terraform init` to initialize terraform to use a local backend.
    - run `terraform plan` and `terraform apply` to create the resources.
    - after the resources have been provisioned, copy the respective outputs exluding the bucket arn output to the corresponding values in the **backend** block in the **backend.tf** file

- Migrate the terraform state to s3
    - uncomment the *terraform* block of the **backend.tf** file
    - run `terraform init` again followed by `terraform plan and apply` to migrate the terraform state to s3 that we have provisioned.

## Commit your changes
- Before you commit your code to a version control system such as git, ensure to add the ***.terraform and terraform*** files to a ***.gitinore*** file

# Provision AWS Client VPN
Now we need to create a separate module for the AWS Client VPN.
- Run the command `touch modules/client-vpn/vpc.tf` to create the first file, 'vpc.tf' in the new module directory.
- enter `cd modules/client-vpn` to change directory into the new module.
- copy and paste the terraform codes in the *vpc.tf* into your newly created ***vpc.tf*** file. The code creates the vpc and other networking resources required by the Client VPN.
- following the same procedure, create other files and copy the terraform codes into the corresponding files
- the ***rds-db.tf*** file creates an RDS-Postgres database in which we will connect to using the AWS Client VPN we are creating.
- After the above steps, go back to the root folder and create the ***client-vpn.tf*** file and populate it with the code. This is where the *modules/client-vpn* module is called.

## Client Authentication 
This is needed to determine if a client is permitted to connect to the client VPN endpoint. There 3 ways to authenticate. 
See the link for more on client auth. [Client Authentication](https://docs.aws.amazon.com/vpn/latest/clientvpn-admin/client-authentication.html#mutual)
We will use *Mutual authentiction(certificate-based)
## Use OpenVPN easy-rsa to generate the server and client certificates and keys, and upload the server certificate and key to ACM
- follow the step in this link to generate the certificates and uplode to ACM. [Generate Certificates](https://docs.aws.amazon.com/vpn/latest/clientvpn-admin/client-authentication.html#mutual)
- Copy the certificate arn that will be returned at the end of the steps. You will need it to create the client vpn.
- go to config/var.tfvars and replace the **certificate_arn** with the certificate arn that you just copied
- also provide the values for the db_username and db_password and the subnet_cidr in the var.tfvars
- add the **config/var.tfvars** to the *.gitignore* file.

## Provision all the resources
- Run `terraform plan` and go through the output to see resources that terraform will provision.
- run `terraform apply` and follow the prompt
Terraform will now provision all the resources we have defined and will return any output defined in the **output.tf** file


- After creating all resource, download the client vpn configuration file and add the client key and cert. before using it with an OpenVPN client [Config file](https://docs.aws.amazon.com/vpn/latest/clientvpn-admin/cvpn-working-endpoint-export.html)