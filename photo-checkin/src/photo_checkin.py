import urllib.parse
import boto3

def get_s3_object(event):
    bucket = event['Records'][0]['s3']['bucket']['name']
    file_name = urllib.parse.unquote_plus(event['Records'][0]['s3']['object']['key'], encoding='utf-8')
    creation_date = event['Records'][0]['eventTime']
    return bucket, file_name, creation_date

def create_db_object_id():
    object_id = ()
    return object_id

def put_db_object(bucket, file_name, creation_date, object_id):

def handler(event, context):     
    bucket, file_name, creation_date = get_s3_object(event)
    object_id = create_db_object_id()
    put_db_object(bucket, file_name, creation_date, object_id)
