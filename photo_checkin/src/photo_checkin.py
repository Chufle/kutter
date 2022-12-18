import urllib.parse
import boto3
import uuid
import os

dynamodb = boto3.resource('dynamodb')
kutter_table_name = os.getenv('KUTTER_TABLE_NAME')
kutter_table = dynamodb.Table(kutter_table_name)

s3 = boto3.resource('s3')
s3client = boto3.client('s3')

store_bucket = os.getenv('STORE_BUCKET_NAME')

def get_s3_object(event):
    bucket = event['Records'][0]['s3']['bucket']['name']
    file_name = urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key'], encoding='utf-8')
    creation_date = event['Records'][0]['eventTime']
    return file_name, bucket, creation_date

def move_s3_object(old_bucket,old_file_name,new_bucket,new_file_name):
    s3client.copy_object(Bucket=new_bucket, CopySource=old_bucket+"/"+old_file_name, Key=new_file_name)
    s3client.delete_object(Bucket = old_bucket, Key = old_file_name)

def generate_db_object_id():
    object_id = str(uuid.uuid4())
    return object_id

def put_db_object(object_id, file_name, bucket, creation_date):
    response = kutter_table.put_item(
        Item={
           "objectId": object_id,
           "objectType": "photo-object",
           "originalFileName": file_name,
           "s3Bucket": bucket,
           "creationDate": creation_date,
   })

def get_file_extension(file_name):
    # Stores characters after '.' in variable file_extension:
    listOfWords = file_name.split(".", 1)
    if len(listOfWords) > 0:
        file_extension = listOfWords[1]
        return file_extension

def handler(event, context):     
    file_name, bucket, creation_date = get_s3_object(event)
    object_id = generate_db_object_id()
    file_extension = get_file_extension(file_name)
    new_file_name = object_id + "." + file_extension
    move_s3_object(bucket, file_name, store_bucket, new_file_name)
    put_db_object(object_id, file_name, store_bucket, creation_date)
