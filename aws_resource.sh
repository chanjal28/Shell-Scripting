#!/bin/bash

##############################################################

#This script will list all the resources in the AWS account
#Authour: Chanjal NC
#Version: v0.0.1


#Following are the supported AWS services by the script
# 1. EC2
# 2. S3
# 3. RDS
# 4. DynamoDB
# 5. Lambda
# 6. EBS
# 7. ELB 
# 8. CloudFront
# 9. CloudWatch
# 10. SNS
# 11. SQS
# 12. Route53
# 13. VPC
# 14. CloudFormation
# 15. IAM

# Usage: ./shell.sh <region> <service_name>
# Example: ./shell.sh us-east-1 EC2

#############################################################

# Check if the required number of arguments are passed

if [ $# -ne 2 ]; then # $#-This will get the command line argument number
  echo  "Usage: $0 <region> <service_name>" #usage: 0 1 2 arguments
  exit 1
fi
#Here we are verifying if the command line argument is equals to 2 or not,if they are not providing 2 arguments then we are saying the script has to be termintaed(exit 1) 
#Also provide an error message to the end user saying that the script is not used properly it has to be as the 2nd line.


# Check if the AWS CLI is installed or not.
# !- provides the result of command -v, command -v - checks if a given command or program(aws) is available on our system
# > /dev/null - Redirects the output(path to aws or nothing) to /dev/null, which is a "black hole" where unwanted output disappears.
if ! command -v aws $> /dev/null; then
  echo "AWS CLI is not installed. Please install and try again."
  exit 1
fi

# Check if the AWS CLI is configured.

if [ ! -d ~/.aws ]; then #if this directory doesnot exist then print the below, if it is configured automatically the dircetory will get created.
  echo " AWS CLI is not configured. Please Configure it and try again."
  exit 1
fi 

# Execute the AWS CLI command based on the service name using switch case.

case $2 in  #syntax for switch case, $2 indicates 2nd argument which is service
ec2)
  aws ec2 describe-instances --region $1
  ;;
s3)
  aws s3api  list-buckets --region $1
  ;;
rds)
  aws rds describe-db-instances --region $1
  ;;
dynamodb)
  aws dynamodb list-tables --region $1
  ;;
lambda)
  aws lambda list-apis --region $1
  ;;
EBS)
  aws ebs describe-volume --region $1
  ;;
ELB)
  aws elb describe-tags --region $1
  ;;
CloudFront)
  aws cloudfront list-distributions --region $1
  ;;
CloudWatch)
  aws cloudwatch describe-alarms --region $1
  ;;
SNS)
  aws sns list-topics --region $1
  ;;
SQS)
  aws sqs list-queues --region $1
  ;;
Route53)
  aws route53 list-hosted-zones --region $1
  ;;
VPC)
  aws ec2 describe-vpc --region $1
  ;;
CloudFormation)
  aws cloudformation describe-stacks --region $1
  ;;
IAM)
  aws iam list-users --region $1
  ;;

esac
