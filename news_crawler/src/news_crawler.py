import requests
import json
import uuid
import os
import boto3
from boto3.dynamodb.conditions import Attr

dynamodb = boto3.resource('dynamodb')
kutter_table_name = os.getenv('KUTTER_TABLE_NAME')
kutter_table = dynamodb.Table(kutter_table_name)

def load_news(topic,dateFrom):
    sortBy = "popularity"
    apiKey = os.getenv('NEWS_API_KEY')
    url = ('https://newsapi.org/v2/everything?'
       'q='+topic+'&'
       'from='+dateFrom+'&'
       'sortBy='+sortBy+'&'
       'apiKey='+apiKey)
    response = requests.get(url)
    return response.json()

def generate_db_object_id():
    return str(uuid.uuid4())

def map_news(news_from_api):
    news = []
    for api_news in news_from_api["articles"]:
        object_id = generate_db_object_id()
        news.append({
            "objectId": object_id,
            "title": api_news["title"],
            "creationDate": api_news["publishedAt"],
            "url": api_news["url"],
        })
    return news

def search_objects_data(search):
    filter_expression = Attr('url').contains(search)
    response = kutter_table.scan(FilterExpression = filter_expression) 
    return { 
         'items' :response['Items']
    }

def put_db_object_news(news_from_api):
    for api_news in news_from_api["articles"]:
        try:
            search_url=api_news["url"]
            response_url = search_objects_data(search_url)
            check_url = response_url['items'][0]
        except Exception as exception:
            object_id = generate_db_object_id()
            response = kutter_table.put_item(
                Item={
                    "objectId": object_id,
                    "objectType": "news-object",
                    "title": api_news["title"],
                    "creationDate": api_news["publishedAt"],
                    "url": api_news["url"],
                }
            )

def handler(event, context):
    topic = event ['queryStringParameters']['topic']
    dateFrom =  event ['queryStringParameters']['dateFrom']
    newsdata = load_news(topic,dateFrom)
    put_db_object_news(newsdata)
    return {
        'statusCode': 200
    }
