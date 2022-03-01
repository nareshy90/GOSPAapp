#!/bin/bash

# Description: Basic Script to copy the ansible playbooks as a zip package,
# and upload to s3.
s3_bucket_name="go-spa-project-source-code"
zip_name="automation"
zip_file="$zip_name.zip"

               
        # Package up Ansible playbooks
        zip -r $zip_file ../Ansible

        # Upload to S3
        aws s3 cp $zip_file s3://$s3_bucket_name/ansible-playbooks/

        # Check if file exists in s3
        aws s3 ls s3://$s3_bucket_name/ansible-playbooks/
        echo "Removing the zip files"
        rm -rf automation.zip