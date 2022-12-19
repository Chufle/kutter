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
    try:
        objectId = event ['queryStringParameters']['objectId']
        try:
            item = get_object_data(objectId)
            return {
                'statusCode': 200,
                'headers': {
                    'Content-Type': 'application/json'
                },
                'body': json.dumps(item)
            }
        except Exception as exception:
            return {
                'statusCode': 404,
                'headers': {
                    'Content-Type': 'application/json'
                },
                'body': "{\"error exception\": \"objectId " + objectId + " not found\"}"
            }
    except Exception as exception:
        return {
            'statusCode': 404,
            'headers': {
                'Content-Type': 'application/json'
            },
            'body': "{\"error exception\": \"wrong query string parameter. should be ?objectId=uuid\"}"
        }
