# Terraform Enterprise FDO - External on Google Cloud Platform

This is a repository to have a TFE FDO external environment on GCP. This is using a PostgreSQL and bucket from GCP. 

The choice of operating system will also determine if you are using `docker` or `podman`

- `tfe_os = "ubuntu"`: installs and runs Terraform Enterprise using **Docker** 
- `tfe_os = "redhat"`: installs and runs Terraform Enterprise using **Podman** 

# Diagram

![](diagram/diagram_tfe_fdo_gcp_external.png)  

# Prerequisites

## License
Make sure you have a TFE license available for use

## GCP
Have your GCP credentials configured

```
gcloud config set account 845080953236-compute@developer.gserviceaccount.com
gcloud auth activate-service-account --key-file=key.json
gcloud config set project <your project>
gcloud auth application-default login
```

#### API enabled for
- Compute Engine API
- Cloud Resource Manager API
- Google DNS API
- IAM Service Account Credentials API
- Identity and Access Management (IAM) API
- Service Usage API
- Google Cloud APIs
- Service Management API
- Google Cloud Storage JSON API
- Cloud Storage API
- Cloud SQL admin API
- Google Cloud Memorystore for Redis API
- Service Networking API
 
```
gcloud services enable serviceusage.googleapis.com      # this might give an error to be enabled from the console first with a link. 

gcloud services enable compute.googleapis.com
gcloud services enable cloudresourcemanager.googleapis.com
gcloud services enable dns.googleapis.com
gcloud services enable iamcredentials.googleapis.com
gcloud services enable iam.googleapis.com
gcloud services enable cloudapis.googleapis.com
gcloud services enable servicemanagement.googleapis.com
gcloud services enable storage-api.googleapis.com
gcloud services enable storage.googleapis.com
gcloud services enable servicenetworking.googleapis.com
gcloud services enable sqladmin.googleapis.com
gcloud services enable redis.googleapis.com
gcloud services enable container.googleapis.com
```


#### Following roles assigned to your account

Option 1:
- have the owner assigned to the account

Option 2:
- Compute Network Admin
- Compute Storage Admin
- Editor
- Project IAM Admin
- kubernetes engine admin
- Compute Instance Admin (v1)
- Compute Security Admin
- Compute Viewer
- DNS Administrator
- Quota Viewer
- Security Admin
- Service Account Admin
- Service Account Key Admin
- Service Account User
- Storage Admin


## Install terraform  
See the following documentation [How to install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)

## TLS certificate
You need to have valid TLS certificates that can be used with the DNS name you will be using to contact the TFE instance.  
  
The repo assumes you have no certificates and want to create them using Let's Encrypt and that your DNS domain is managed under GCP . 

# How to

- Clone the repository to your local machine
```sh
git clone https://github.com/munnep/tfe_fdo_gcp_external.git
```
- Go to the directory  
```sh
cd tfe_fdo_gcp_external
```
- Add your gcp authentication key as `key.json`
- create a file called `variables.auto.tfvars` with the following contents and your own values
```
# General
tag_prefix        = "tfe22"                       # TAG prefix for names to easily find your GCP resources
dns_hostname      = "tfe22"                       # DNS hostname for the TFE
dns_zonename      = "hashicorpdemo.com"           # DNS zone name to be used
tfe_release       = "1.1.3"                       # Version number for the release to install. This must have a value
tfe_password      = "Password#1"                  # TFE password for the dashboard and encryption of the data
public_key        = "ssh-rsa AAAAB3NzaN"          # The public key for you to connect to the server over SSH
certificate_email = "patrick.munne@hashicorp.com" # Your email address used by TLS certificate 
tfe_license       = "02MV4UU43BK5HGYYTOJZ"        # license file being used
rds_password      = "Password#1"                  # password used for PostgreSQL
# gcp
gcp_region        = "europe-west4"                # GCP region creating the resources
vnet_cidr         = "10.214.0.0/16"               # Network to be used
gcp_project       = "hc-ff9323d13b0e4e0da8171"    # GCP project id (found in keys.json)
gcp_location      = "EU"                          # location to create SQL and bucket 
tfe_os            = "redhat"                      # ubuntu  or redhat
```
- Terraform initialize
```
terraform init
```
- Terraform plan
```
terraform plan
```
- Terraform apply
```
terraform apply
```
- Terraform output should create 27 resources and show you the public dns string you can use to connect to the TFE instance
```
Apply complete! Resources: 27 to added, 0 to changed, 0 to destroyed.

Outputs:

ssh_tfe_server = "ssh cloud-user@tfe25.hc-0ecd51335ae74f1089a9a431017.gcp.sbx.hashicorpdemo.com"
tfe_appplication = "https://tfe25.hc-0ecd51335ae74f1089a9a431017.gcp.sbx.hashicorpdemo.com"
```
- You can now login to the application with the username `admin` and password specified in your variables.

## Startup logs

With Ubuntu operating system the logs during installation are found in `/var/log/cloud-init-output.txt`. 
With RedHat and GCP you will need to use `journalctl -u google-startup-scripts.service --no-page -f`

# TODO

# DONE
- [x] build network according to the diagram
- [x] use standard ubuntu 
- [x] Create the disks where TFE should store it's data to be attached to the virtual machine
- [x] create a virtual machine in a public network with public IP address.
    - [x] firewall inbound are all from user building external ip
    - [x] firewall outbound rules
          user building external ip
- [x] create an elastic IP to attach to the instance
- [x] Create a valid certificate to use 
- [x] point dns name to public ip address
- [x] create a bucket
- [x] create PostgreSQL instance
- [x] install TFE
- [x] RedHat with podman available as an option