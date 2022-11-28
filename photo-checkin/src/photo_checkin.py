import urllib.parse
import boto3

def get_s3_object(event):
    bucket = event['Records'][0]['s3']['bucket']['name']
    file_name = urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key'], encoding='utf-8')
    creation_date = event['Records'][0]['eventTime']
    return file_name, bucket, creation_date

def generate_db_object_id():
    object_id = test123
    return object_id

def put_db_object(object_id, file_name, bucket, creation_date):
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table('kutter-table')
    response = table.put_item(
        Item={
           "objectId": object_id,
           "originalFileName": file_name,
           "s3Bucket": bucket,
           "creationDate": creation_date,
   })

def handler(event, context):     
    file_name, bucket, creation_date = get_s3_object(event)
    object_id = generate_db_object_id()
    put_db_object(object_id, file_name, bucket, creation_date)
