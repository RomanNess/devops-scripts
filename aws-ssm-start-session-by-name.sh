#!/usr/bin/env bash

set -o errexit
set -o nounset

if (( $# != 1 )); then
    echo "Usage: $0 <EC2-NAME-SUBSTRING>"
    echo "Connects to first ec2 instance matching the name tag via SSM session."
    exit 1
fi

NAME_SUBSTRING="$1"

EC2_INSTANCE_IDS=$(aws ec2 describe-instances --query "Reservations[].Instances[?Tags[?Key == 'Name' && contains(Value, '${NAME_SUBSTRING}')][]][].InstanceId" --output text)

if [ "${EC2_INSTANCE_IDS}" == "" ]; then
    echo "Found no instance with Name:'*${NAME_SUBSTRING}*' for aws-caller-identity: '$(aws sts get-caller-identity --query Arn --output text)'"
    exit 0
fi

echo "Connecting to first instance of: $EC2_INSTANCE_IDS"
aws ssm start-session --target $(echo "${EC2_INSTANCE_IDS}" | head -n 1)