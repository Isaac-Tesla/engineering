import requests
import json

from decimal import Decimal
import boto3


def _upload_to_dynamodb(JSON_DATA, dynamodb=None):

    if not dynamodb:
        dynamodb = boto3.resource('dynamodb', endpoint_url="http://localhost:8000")

    table = dynamodb.Table('Movies')
    for item in JSON_DATA:
        email = str(js[item]['results'][0]['email'])
        print("Adding info:", email)
        table.put_item(Item=email)


def _api_collect_json():
    max_results = 2
    js = []
    for i in range(0, max_results):
        response = requests.get("https://randomuser.me/api/")
        response.encoding = 'utf-8'
        js.append(response.json())
    return js


if __name__ == "__main__":

    print("Get information from generic API -> json")
    js = _api_collect_json()

    print(js[0]['results'][0]['email'])

    print("Upload JSON data to DynamoDB")

    _upload_to_dynamodb(js)

    print("Complete.")