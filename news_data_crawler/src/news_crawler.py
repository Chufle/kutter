import requests

url = ""

def load_news():
    response = requests.get(url)
    return response.json()["data"]