#! /usr/bin/env bash
set -e # stop the execution of the script if it fails

# Retrieve the list of CloudFront Origin Access Identities and get the ID of the latest one
latest_oai=$(aws cloudfront list-cloud-front-origin-access-identities \
    --query "CloudFrontOriginAccessIdentityList.Items[-1].Id" \
    --output text)

# Print the ID of the latest CloudFront Origin Access Identity
echo "Latest OAI ID: $latest_oai"

# Create a bucket policy that allows read and write access to the specified S3 bucket for the latest OAI
aws s3api put-bucket-policy \
    --bucket warnerbell.com \
    --policy '{
        "Version": "2012-10-17",
        "Id": "CloudFrontBucketPolicy",
        "Statement": [
            {
                "Sid": "GrantBucketAccessToOAI",
                "Effect": "Allow",
                "Principal": {
                    "AWS": "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity '$latest_oai'"
                },
                "Action": [
                    "s3:GetObject",
                    "s3:PutObject"
                ],
                "Resource": "arn:aws:s3:::warnerbell.com/*"
            }
        ]
    }'
    
sleep 10

latest_oai=$(aws cloudfront list-cloud-front-origin-access-identities \
    --query "CloudFrontOriginAccessIdentityList.Items[-1].Id" \
    --output text)

aws s3api put-bucket-policy \
    --bucket www.warnerbell.com \
    --policy '{
        "Version": "2012-10-17",
        "Id": "CloudFrontBucketPolicy",
        "Statement": [
            {
                "Sid": "GrantBucketAccessToOAI",
                "Effect": "Allow",
                "Principal": {
                    "AWS": "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity '$latest_oai'"
                },
                "Action": [
                    "s3:GetObject",
                    "s3:PutObject"
                ],
                "Resource": "arn:aws:s3:::www.warnerbell.com/*"
            }
        ]
    }'

sleep 10

latest_oai=$(aws cloudfront list-cloud-front-origin-access-identities \
    --query "CloudFrontOriginAccessIdentityList.Items[-1].Id" \
    --output text)

aws s3api put-bucket-policy \
    --bucket logs.warnerbell.com \
    --policy '{
        "Version": "2012-10-17",
        "Id": "CloudFrontBucketPolicy",
        "Statement": [
            {
                "Sid": "GrantBucketAccessToOAI",
                "Effect": "Allow",
                "Principal": {
                    "AWS": "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity '$latest_oai'"
                },
                "Action": [
                    "s3:GetObject",
                    "s3:PutObject"
                ],
                "Resource": "arn:aws:s3:::logs.warnerbell.com/*"
            }
        ]
    }'
