set -eu

read -p "Date (YYYYMMDD): " DATE
read -p "Hour (00-23): " HOUR
read -p "aws profile (default): " PROFILE

if [ -z "$PROFILE" ]; then
  PROFILE="default"
fi

BACKET="bucket-name-datadog-log"
URL=$BACKET/dt=$DATE/hour=$HOUR/

mkdir -p ./logs
aws --profile $PROFILE s3 ls $URL | awk '{print $4}' | xargs -I{} aws --profile $PROFILE s3 cp s3://$URL{} - | zcat | gojq -r '.message' >> logs/$DATE$HOUR.log