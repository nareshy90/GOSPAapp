# Deployment Process

This document explains about deployment process for GO Language SPA Application on AWS cloud


## Cloud Formation stacks sequence 
 1. Networking
 2. IAM
 3. Security Groups
 4. Storage
 5. Shell Scripts
 6. Secrets Manager
 7. Database
 8. ALB and Listeners
 9. EC2 ASG
 10. Configuration Deployment using Ansible and SSM
 11. WAF

## Step by step process
Login to WSL to deploy the stacks using Sceptre
>**Note** Refer [Prerequisites](https://github.com/nareshy90/GOSPAapp/blob/main/doc/Prerequisites.md) document for configuring the AWS CLI and Sceptre

### Clone the GitHub repository to your local system
`git clone https://github.com/nareshy90/GOSPAapp`
1. Networking

	  * Deploy VPC stack
	  * Commands to deploy using Sceptre, change the directory to GOSPAapp
	  `cd GOSPAapp/networking`
	  * Run below command to validate the stack
	 `sceptre validate dev/vpc.yaml`
	 * Run below command to generate yaml file
	 `sceptre generate dev/vpc.yaml`
	 
	 * Below command to launch the stack 
	 `sceptre launch -y dev/vpc.yaml`

	 * Deploy vpc endpoint stacks 
	 `sceptre launch -y dev/vpc-ec2messages-endpoint.yaml`
	 `sceptre launch -y dev/vpc-ssm-endpoint.yaml`
	 `sceptre launch -y dev/vpc-ssmmessages-endpoint.yaml`

	  * Sample output
	  
	  > [2022-03-01 13:27:28] - dev/vpc - Launching Stack  
[2022-02-28 13:27:28] - dev/vpc - Stack is in the PENDING state  
[2022-02-28 13:27:28] - dev/vpc - Creating Stack  
[2022-02-28 13:27:28] - dev/vpc gospa-app-project-dev-vpc AWS::CloudFormation::Stack CREATE_IN_PROGRESS User Initiated  
[2022-02-28 13:27:33] - dev/vpc InternetGateway AWS::EC2::InternetGateway CREATE_IN_PROGRESS  
[2022-02-28 13:27:33] - dev/vpc VPC AWS::EC2::VPC CREATE_IN_PROGRESS  
[2022-02-28 13:27:37] - dev/vpc VPC AWS::EC2::VPC CREATE_IN_PROGRESS Resource creation Initiated  
[2022-02-28 13:27:37] - dev/vpc InternetGateway AWS::EC2::InternetGateway CREATE_IN_PROGRESS Resource creation Initiated  
[2022-02-28 13:27:49] - dev/vpc VPC AWS::EC2::VPC CREATE_COMPLETE  
[2022-02-28 13:27:54] - dev/vpc PrivateRouteTable1 AWS::EC2::RouteTable CREATE_IN_PROGRESS  
[2022-02-28 13:27:54] - dev/vpc PublicSubnet2 AWS::EC2::Subnet CREATE_IN_PROGRESS  
[2022-02-28 13:27:54] - dev/vpc PublicRouteTable AWS::EC2::RouteTable CREATE_IN_PROGRESS  
[2022-02-28 13:27:54] - dev/vpc PrivateSubnet2 AWS::EC2::Subnet CREATE_IN_PROGRESS  
[2022-02-28 13:27:54] - dev/vpc InternetGateway AWS::EC2::InternetGateway CREATE_COMPLETE

> **Info** Refer [Architetcture doc](https://github.com/nareshy90/GOSPAapp/blob/main/doc/ArchitecturalOverview.md) to check what services this stack is going to deploy

>**Note** You need to be on the stack's main directory to deploy the templates.
> For Eg. Here networking is the main directory and actual Cloud Formation template is in templates folder and vpc.yaml under config is the input file. See below basic directory structure in Sceptre
**networking**
├── config
│   ├── config.yaml
│   └── dev
│       ├── config.yaml
│       └── vpc.yaml
└── templates
    └── vpc.yaml

2.  IAM

	  * Deploy IAM stacks
		   `cd ../IAM`
		   `sceptre launch -y dev/s3-access-role.yaml`
   		   `sceptre launch -y dev/iam-ssm-role.yaml`
   		   `sceptre launch -y dev/iam-instance-role.yaml`

3. Security Groups
		
	*  Deploy security groups
	 `cd ../security-groups`
	`sceptre launch -y dev/ec2-rds-alb.yaml`
		

4. Storage

	* Deploy S3 bucket stacks
		`cd ../storage`
		`sceptre launch -y dev/s3-app-bucket.yaml`
		`sceptre launch -y dev/s3-elb-logging-bucket.yaml`


5. Secrets Manager

   *  Deploy Secrets Manager stack
   `cd ../SecretsManager`
   `sceptre launch -y dev/rds-secret.yaml`
  
  >**Note** Update Secrets ARN on rds/config/dev/rds-postgresql.yaml file at line no 8 for MyRDSSecret parameter 
	
6. Database

	* Deploy RDS stack
	`cd ../rds`
	`sceptre launch -y dev/rds-postgresql.yaml`
	
7. ALB and Listeners
	* Deploy ALB and Listener stack
	`cd ../alb`
	`sceptre launch -y dev/alb-internet-facing.yaml`
	`sceptre launch -y dev/alb-listener.yaml`

8. Shell Scripts

	* Run shell scripts to upload source code and for creating EC2 key pair
	`cd ../scripts`
	`./create-ec2-keypair.sh`
	`./upload-source-code-to-s3.sh`

>**Note** Update ec2 key pair name on EC2-ASG/config/dev/ec2-asg.yaml file at line no 7 for KeyName parameter 
		  
9.  EC2 ASG

	* Deploy EC2 ASG stack
	`cd ../EC2-ASG`
	`sceptre launch -y dev/ec2-asg.yaml`
   
 10. Configuration Deployment using Ansible and SSM
      
      * Update new RDS db endpoint name and DB password  on Ansible role
          `GOSPAapp/Ansible/roles/gospa/vars/main.yaml`
	 * And run below scripts now to deploy the application configuration 
	 `cd ../scripts`
	 `./copy-playbooks-s3-bucket.sh`
	 `./create-ssm-association.sh`

### With this application will be up and running on the EC2 instances

11. WAF
	  
	  *  Deploy WAF stacks
	  `cd ../WAF`
	  * Update your desired IPs for WAF IP set in input file
	  `sceptre launch -y dev/waf-ip-set.yaml`
	  * Update WAF IP set ARN at line number 28 on wberules.yaml input file
	  `sceptre launch -y dev/webrules.yaml.yaml`
	  `sceptre launch -y dev/webrules-association.yaml`

## Note down the ALB DNS name and open it in your web browser and you should see like below if the deoployment is successful.

![Application Screenshot](https://github.com/nareshy90/GOSPAapp/blob/main/App-screenshot.png)
	  
