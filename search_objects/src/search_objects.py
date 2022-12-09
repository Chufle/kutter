import json
import boto3
from boto3.dynamodb.conditions import Attr, Or
from typing import Union

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('kutter-table')

def search_objects_data(search, exclusiveStartKey, limit):
    filter_expression = Or( Attr('creationDate').contains(search), Attr('originalFileName').contains(search))
    response = table.scan(
        Limit = limit,  
        FilterExpression = filter_expression,
        ExclusiveStartKey = {"objectId":exclusiveStartKey}) if  exclusiveStartKey is not None else table.scan(Limit = limit,FilterExpression = filter_expression) 
    return { 
         'items' :response['Items'],
         'LastEvaluatedKey': response['LastEvaluatedKey']
    }

def handler(event, context):
    search = event ['queryStringParameters']['search']
    exclusiveStartKey: Union[str, None] = None
    limit: int = 10
    items = search_objects_data(search,exclusiveStartKey,limit)
    return {
        'statusCode': 200,
        'headers': {
            'Content-Type': 'application/json'
        },
        'body': json.dumps(items)
    }
