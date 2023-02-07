#!/bin/bash

set -eu

read -p "Date (YYYYMMDD): " DATE
read -p "Hour (00-23): " HOUR

BACKET="bucket-name-datadog-log"

aws s3 ls $URL | fzf | awk '{print $4}' | xargs -I{} aws s3 cp s3://$URL{} - | zcat | gojq -r '.message'
