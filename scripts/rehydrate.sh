#!/bin/bash

set -eu

## Change this to your bucket name
BACKET="YOUR-BUCKET-NAME"

read -p "Date (YYYYMMDD): " DATE
read -p "Hour (00-23): " HOUR
read -p "aws profile (default): " PROFILE

if [ -z "$PROFILE" ]; then
  PROFILE="default"
fi

aws --profile $PROFILE s3 ls $URL | fzf | awk '{print $4}' | xargs -I{} aws --profile $PROFILE s3 cp s3://$URL{} - | zcat | gojq -r '.message'
