import urllib.parse
import boto3
import uuid
import os

dynamodb = boto3.resource('dynamodb')
kutter_table_name = os.getenv('KUTTER_TABLE_NAME')
kutter_table = dynamodb.Table(kutter_table_name)

s3 = boto3.resource('s3')

def get_s3_object(event):
    bucket = event['Records'][0]['s3']['bucket']['name']
    file_name = urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key'], encoding='utf-8')
    creation_date = event['Records'][0]['eventTime']
    return file_name, bucket, creation_date

def rename_s3_object(bucket,old_file_name,new_file_name):
    s3client = boto3.client('s3')
    s3client.copy_object(Bucket=bucket, CopySource=bucket+"/"+old_file_name, Key=new_file_name)

def generate_db_object_id():
    object_id = str(uuid.uuid4())
    return object_id

def put_db_object(object_id, file_name, bucket, creation_date):
    response = kutter_table.put_item(
        Item={
           "objectId": object_id,
           "originalFileName": file_name,
           "s3Bucket": bucket,
           "creationDate": creation_date,
   })

def handler(event, context):     
    file_name, bucket, creation_date = get_s3_object(event)
    object_id = generate_db_object_id()
    rename_s3_object(bucket,file_name,object_id)
    put_db_object(object_id, file_name, bucket, creation_date)
