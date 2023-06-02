#!/bin/bash

#Shell script to execute cloudFormation teamplate for Vpc setup2....

#Declaring variables
echo "Enter stack name"
read  MY_STACK
echo "Enter Template Name"
read  TEMPLATE_BODY
echo "Enter CIDR Block for vpc"
read  CIDR_VPC
echo "Enter CIDR value for PublicSubnets"
read  CIDR_PUBLIC_SUBNET
echo "Enter CIDR value for PrivatesubnetA"
read  CIDR_PRIVATE_SUBNET_A
echo "Enter CIDR value for PrivatesubnetB"
read  CIDR_PRIVATEc_SUBNET_B
echo "Enter DestinationCidrBlock value"
read  DESTINATION_CIDR_BLOCK

#Create cloudformation stack to create a VPC

aws cloudformation create-stack --stack-name ${MY_STACK} --template-body ${TEMPLATE_BODY}




