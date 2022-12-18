import boto3
import uuid
import os
from datetime import date

dynamodb = boto3.resource('dynamodb')
kutter_table_name = os.getenv('KUTTER_TABLE_NAME')
kutter_table = dynamodb.Table(kutter_table_name)

def generate_db_object_id():
    object_id = str(uuid.uuid4())
    return object_id

def put_db_object(object_id, news_location):
    today = date.today()
    creation_date = today.strftime("%Y-%m-%d")
    response = kutter_table.put_item(
        Item={
           "objectId": object_id,
           "objectType": "project-object",
           "newsLocation": news_location,
           "creationDate": creation_date
        }
    )

def handler(event, context):
    news_location = event ['queryStringParameters']['location']
    object_id = generate_db_object_id()
    put_db_object(object_id, news_location)
