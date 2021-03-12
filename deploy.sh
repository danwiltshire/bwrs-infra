#!/bin/bash -e

# Usage: ./deploy.sh [prod/dev/etc]
#
# ~/.aws/config
#   [default]
#       region = eu-west-1
#   [profile prod]
#       role_arn = arn:aws:iam::123456789012:role/AccessRole
#       source_profile = default
#       region = eu-west-1
#   [profile dev]
#       role_arn = arn:aws:iam::123456789012:role/AccessRole
#       source_profile = default
#       region = eu-west-1

CFN_TEMPLATE="infrastructure.yml"
APPLICATION="bwrs"
ENVIRONMENT="$1"

function log_usage {
    echo "Usage: ./deploy.sh [prod/dev/etc]"
}

function lint {
    cfn-lint "$1"
}

function deploy {
    aws cloudformation deploy \
        --template-file "$1" \
        --stack-name "$APPLICATION-$2" \
        --profile $2 \
        --parameter-overrides \
          Application=$APPLICATION \
          Environment=$2
}

# Ensure an enviroment is specified
if [ -z "$ENVIRONMENT" ]; then
  echo "Environment name not supplied!"
  log_usage
  exit 1
fi

lint "$CFN_TEMPLATE" && deploy "$CFN_TEMPLATE" "$ENVIRONMENT"
