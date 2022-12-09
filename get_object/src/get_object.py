import json
import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('kutter-table')

def get_object_data(objectId):
    response = table.get_item(
        Key={
            'objectId': objectId
        }
    )
    return response['Item']

def handler(event, context):
    objectId = event ['queryStringParameters']['objectId']
    item = get_object_data(objectId)
    return {
        'statusCode': 200,
        'headers': {
            'Content-Type': 'application/json'
        },
        'body': json.dumps(item)
    }
