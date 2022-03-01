# Pre requisites 

This document explains about pre requisites for deploying GO Language SPA Application


##  Key Setup Details
1. Windows 10 laptop with WSL 2 enabled
2. Download and Install Visual Studio Code
3. Active AWS subscription
4. Cleanup AWS default services
5. Setup AWS account
6. Login to WSL
7. Download and Install latest AWS CLI 
8. Setup AWS configuration
9. GitHub setup
10. Sceptre setup

## Detailed Steps

1. Windows 10 laptop with WSL 2 enabled

     *  Refer below link to install WSL2 on your Windows 10 laptop

		[https://docs.microsoft.com/en-us/windows/wsl/install-win10]

2.  Download and Install Visual Studio Code

	  * Refer below link to install Visual Studio Code

		https://code.visualstudio.com/download
	* We will use the Visual Studio for writing the code to deploy infrastructure

3. Active AWS subscription
		
	*  Signup for AWS account and activate the subscription

4. Cleanup AWS default services

	* Delete default VPC which will delete all the subnets, route tables and internet gateway and any other services
	
5. Setup AWS account

	*  Create an IAM user with power user access policy and IAM full access policy attached
	* And save the AWS credentials in a secure place

6. Login to WSL

   *  Open command prompt from start menu and type wsl
   * It will land you into Linux distribution you installed at step no 1
	
7. Download and Install latest AWS CLI on WSl

	* Refer below link to install AWS CLI on WSL
	 https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
8. Setup AWS configuration
	* Run below command to configure the AWS credentials on WSL
	  >aws configure
	 
	 * Provide the AWS user credentials which you have saved on the above step
	 * Verify your login is successful or not using below command
		  >aws sts get-caller-identity
		  
9.  GitHub setup 

	* Signup for Github account if you don't have one using below link 
	https://github.com/
	
    * On WSL run below command to clone the GitHub repository
      > git clone https://github.com/nareshy90/GOSPAapp 
   
 10. Sceptre setup
 
	 * Download and install Sceptre using pip on your WSL
	   > pip install sceptre
	   
	  * For more information on Sceptre refer below link
	  https://github.com/Sceptre/sceptre
     
     * Verify the version using below command to check for the successful installation 
		>	sceptre --version
