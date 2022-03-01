# Architectural Overview

This document explains about architectural overview of GO Language SPA Application on AWS cloud

![Architecture Diagram](https://github.com/nareshy90/GOSPAapp/blob/main/Arch_diagram.jpeg)

##  AWS Infrastructure for GO SPA APP
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

## Detailed Overview
Detailed overview of all the Cloud Formation stacks and others
1. Networking

     *  Networking stack creates below services
	      * VPC
	      * 2 Public subnets
	      * 2 Private subnets
	      * 2 Nat Gateways
	      * 2 Internet Gateway
	      * 4 Route tables with 2 Public subnet association with Internet Gateway and 2 Private subnets association with NAT Gateway
	      * 3 VPC Endpoints for SSM to manage EC2 instances
	 

2.  IAM

	  * IAM stack creates following roles
		   *	S3 Access role for EC2
		   *	SSM role for EC2 to manage by SSM
		   *	Instance profile to attach with EC2

3. Security Groups
		
	*  Security Groups stack creates below security groups
		* EC2 security group with below traffic
			* Egress traffic for RDS port 5432 and 443 for SSM
			* Ingress traffic for SSH port 22,443 for SSM  and 3000 to allow ALB's traffic
		* RDS security group with below traffic
			* Ingress traffic for port 5432 from EC2 security group
		* ALB security group with below traffic
			* Ingress traffic for port 80 from anywhere
			* Egress traffic to EC2 security group
		

4. Storage

	* This stack create below S3 buckets
		* s3 bucket for storing source code
		* S3 bucket for load balancer logging 
	
5. Shell Scripts

	* Following shell scripts created to automate the manual tasks
		*  For downloading and uploading source code to S3 bucket
		* For creating EC2 key pair and storing the same on Secrets Manager
		* Packing up the Ansible playbooks and upload to S3 bucket
		* For creating AWS SSM association to deploy application configuration using Ansible
	

6. Secrets Manager

   *  Secrets Manager stack will create a random password for RDS PostgreSQL DB and will use the secrets ARN in RDS stack to use the password
  
	
7. Database

	* RDS stack will be created with PostgreSQL 9.6.20 version with db.t2.small instance class and with 20GB storage minimum and 25 maximum
	
8. ALB and Listeners
	* ALB stack creates the following services
		* Internet facing ALB in public subnet with 2 AZs
		* Listener 80 and Target group with HTTP port 3000, target type will be instance but instance id we do not mention here as we will register directly from EC2 Auto Scaling stack using target group ARN
	 
		  
9.  EC2 ASG

	* This stack will create EC2 Auto Scaling Group with minimum 2 t2.micro instance and maximum 5 instances on 2 different AZs using 2 private subnets
   
 10. Configuration Deployment using Ansible and SSM
 
	 * Ansible role has been created to deploy the **config.toml** file using latest DB endpoint name and password and it will update the db and start the application
	 * This role will be stored on S3 bucket which AWS SSM association will download from S3 and run on the server

11. WAF
	  * This stack will deploy following services
		* WAF IP set which can have the IPs allowed to access the application
		* WAF Rules to allow the IP set
		* WAF Association to associate the internet facing ALB
