#! /usr/bin/env bash
set -e # stop the execution of the script if it fails

CF_PATH="/workspace/cloud-resume-challenge/cfn/cloudfrnt.yaml"
echo $CF_PATH

#cfn-lint validate $CF_PATH

aws cloudformation deploy \
  --stack-name "Cldfrnt-Distro" \
  --s3-bucket cfmtn-stacks-2023 \
  --template-file "$CF_PATH" \
  --no-execute-changeset \
  --tags group=crc-stuff \
  --capabilities CAPABILITY_NAMED_IAM