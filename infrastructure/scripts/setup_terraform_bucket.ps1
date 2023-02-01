$S3_BUCKET_NAME='nfish-des-kutter-terraform-state'
$REGION='us-west-2'
aws s3api create-bucket --bucket $S3_BUCKET_NAME --region $REGION --create-bucket-configuration LocationConstraint=$REGION
