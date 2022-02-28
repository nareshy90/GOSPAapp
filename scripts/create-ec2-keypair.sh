#!/bin/bash
# Read the user input   
  
echo "Enter the Key Name: "  
read Key_name
echo "Creating EC2 keypair"
#aws ec2 create-key-pair --key-name $Key_name|jq '.KeyMaterial'>/tmp/ec2-private-key.json
aws ec2 create-key-pair --key-name $Key_name > /tmp/ec2-private-key.json
echo "Enter the secret name"
read secret_name
echo "Enter the secret description"
read secret_description
echo "Creating the secret $secret_name to store the key in secrets manager"
aws secretsmanager create-secret --name $secret_name --description "$secret_description"  --secret-string file:///tmp/ec2-private-key.json
echo "Removing the key from local file"
rm -rf /tmp/ec2-private-key.json