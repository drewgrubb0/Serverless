import requests
import os
import json

import boto3
import elasticsearch

maps_link = "https://maps.googleapis.com/maps/api/place/textsearch/json"
api_key = os.environ['api-key']

dynamoDB = boto3.resource('dynamodb')

def retrieveInformation():
    return requests.get(maps_link, api_key)

def main():
    response = retrieveInformation()

    if(response.response_code != 200):
        print("Oops")
    
if __name__ == "__main__":
    main()