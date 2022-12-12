import json
import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('kutter-table')

def handler(event, context):
    body = table.scan()
    items = body['Items']
    return {
        'statusCode': 200,
        'headers': {
            'Content-Type': 'application/json'
        },
        'body': json.dumps(items)
    }