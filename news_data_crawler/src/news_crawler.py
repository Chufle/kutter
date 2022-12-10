import requests
import json
import uuid
import os
import boto3

topic = "Harburg"
dateFrom = "2022-12-03"
sortBy = "popularity"
apiKey = "22f8570bfae94270854b80c15e6d89b8"
url = ('https://newsapi.org/v2/everything?'
       'q='+topic+'&'
       'from='+dateFrom+'&'
       'sortBy='+sortBy+'&'
       'apiKey='+apiKey)

dynamodb = boto3.resource('dynamodb')
kutter_table_name = os.getenv('KUTTER_TABLE_NAME')
kutter_table = dynamodb.Table(kutter_table_name)

def load_news():
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
    newsdata = load_news()
    put_db_object_news(newsdata)

#test = map_news(newsdata)
#print(test)
