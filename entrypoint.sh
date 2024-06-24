#!/bin/sh

# Read branch name from the stored file
BRANCH="develop"

echo ":zap: Using branch: $BRANCH"

# export AWS_PROFILE="divyesh"

# Load environment variables based on the branch (example)
ENV_FILE="$BRANCH.env"
echo ":zap: Load environment variables from s3://mytestbuckedk/$ENV_FILE"
aws s3 cp "s3://mytestbuckedk/$ENV_FILE" /home/zt38
# cp /tmp/.env /app/

# echo ":zap: Environment variables accessible by container:"
# env
