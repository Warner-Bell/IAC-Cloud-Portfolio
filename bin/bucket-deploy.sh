#! /usr/bin/env bash
set -e # stop the execution of the script if it fails

BKT_PATH="/workspace/cloud-resume-challenge/cfn/s3Buckets.yaml"
echo $BKT_PATH

cfn-lint validate $BKT_PATH

aws cloudformation deploy \
  --stack-name "CRC-s3buckets" \
  --s3-bucket cfmtn-stacks-2023 \
  --template-file "$BKT_PATH" \
  --no-execute-changeset \
  --tags group=crc-stuff \
  --capabilities CAPABILITY_NAMED_IAM