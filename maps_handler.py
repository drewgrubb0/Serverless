import requests
import os
import json

maps_link = "https://maps.googleapis.com/maps/api/place/textsearch/json"
api_key = os.environ['api-key']

def retrieveInformation():
    return requests.get(maps_link, api_key)

def main():
    response = retrieveInformation()

    if(response.response_code != 200):
        print("Oops")
    
if __name__ == "__main__":
    main()