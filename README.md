# kutter
"kutter" is a completly serverless content management system for photos and news-articles with an API Gateway based REST Interface.
* Photo files are stored in a S3 bucket and metadata in a Dynamodb table
* News-articles are imported from the online NEWS-API
* All operations are computed by lambda functions and are secured by IAM policies
* For the deployment I used Terraform and I set up a CICD pipeline
