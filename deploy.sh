# Usage: ./deploy.sh [prod/dev/etc]
#
# ~/.aws/config
#   [default]
#       region = eu-west-1
#   [profile prod]
#       role_arn = arn:aws:iam::123456789012:role/AccessRole
#       source_profile = default
#   [profile dev]
#       role_arn = arn:aws:iam::123456789012:role/AccessRole
#       source_profile = default

function log_usage {
    echo "Usage: ./deploy.sh [prod/dev/etc]"
}

if [ -z "$1" ]; then
  echo "Environment name not supplied!"
  log_usage
  exit 1
fi

aws cloudformation deploy --template-file infrastructure.yml --stack-name "bwrs-$1" --profile $1