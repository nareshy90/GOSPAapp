#!/bin/bash

#This script will create SSM association which will run SSM automation docuemnt with Ansible Playbook

echo "Creating SSM association for running Ansible playbook target as Tags"

aws ssm create-association --name "AWS-ApplyAnsiblePlaybooks" \
--targets '[{"Key":"tag:Name","Values":["go-spa-dev"]}]' \
--parameters '{"SourceType":["S3"],"SourceInfo":["{\"path\":\"https://s3.ap-southeast-2.amazonaws.com/go-spa-project-source-code/ansible-playbooks/automation.zip\"}"],"InstallDependencies":["True"],"PlaybookFile":["Ansible/app-playbook.yml"],"ExtraVariables":["SSM=True"],"Check":["False"],"Verbose":["-v"]}' \
--association-name "Go-SPA-APP-Config-AnsibleAssocation"