import json
import boto3
from boto3.dynamodb.conditions import Attr, Or

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('kutter-table')

def search_objects_data(search, limit):
    filter_expression = Or( Attr('creationDate').contains(search), Attr('originalFileName').contains(search))
    response = table.scan(Limit = limit,FilterExpression = filter_expression) 
    return { 
         'items' :response['Items']
    }

def handler(event, context):
    try:
        search = event ['queryStringParameters']['search']
        limit = int(10)
        items = search_objects_data(search,limit)
        return {
            'statusCode': 200,
            'headers': {
                'Content-Type': 'application/json'
            },
            'body': json.dumps(items)
        }
    except Exception as exception:
        return {
            'statusCode': 404,
            'headers': {
                'Content-Type': 'application/json'
            },
            'body': "{\"error exception\": \"wrong query string parameter. should be ?search=\"}"
        }
