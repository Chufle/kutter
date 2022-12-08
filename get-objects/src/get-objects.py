import json
import boto3

dynamodb = boto3.resource('dynamodb')

def handler(event, context):
    table = dynamodb.Table('kutter-table')
    body = table.scan()
    items = body['Items']
    return {
        'statusCode': 200,
        'headers': {
            'Content-Type': 'application/json'
        },
        'body': json.dumps(items)
    }