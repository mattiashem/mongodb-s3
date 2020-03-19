#!/bin/bash
echo "Setting up AWS cli to be user"
echo "Copy your AWS key and secret to files"
mkdir /root/.aws/
echo "[default]" > /root/.aws/credentials
echo "aws_access_key_id = $AWS_ACCESS_KEY_ID" >> /root/.aws/credentials
echo "aws_secret_access_key = $AWS_SECRET_ACCESS_KEY" >> /root/.aws/credentials
echo "[default]" > /root/.aws/config
echo "Aws credentials done"



##########
#
# Test aws to list buckets

#aws s3api list-buckets