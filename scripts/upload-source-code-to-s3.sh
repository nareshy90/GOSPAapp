#!/bin/bash
cd /tmp
wget https://github.com/servian/TechChallengeApp/releases/download/v.0.9.0/TechChallengeApp_v.0.9.0_linux64.zip
aws s3 cp TechChallengeApp_v.0.9.0_linux64.zip s3://go-spa-project-source-code/
aws s3 ls s3://go-spa-project-source-code/