import requests
import json
import uuid
import os
import boto3

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
    object_id = str(uuid.uuid4())
    return object_id

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

def put_db_object_news(news_from_api):
    for api_news in news_from_api["articles"]:
        object_id = generate_db_object_id()
        response = kutter_table.put_item(
            Item={
                "objectId": object_id,
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
