#!/usr/bin/python

import logging
import logging.config
from pathlib import Path
from os import listdir
from os.path import isfile, join
import requests
import json
import sys
import pandas as pd
from pandas import json_normalize

import mongodb

root_dir = Path(__file__).parent.absolute()


def _api_collect_json(max_results: int) -> json:
    """
    Summary:
        Collects a set number of results from a public API.

    Returns:
        [Pandas dataframe]: A dataframe consisting of flattened
            results from a public JSON API for users.

    """
    js = []
    for i in range(0, max_results):
        response = requests.get("https://randomuser.me/api/")
        response.encoding = 'utf-8'
        js.append(response.json()['results'][0])
    return js



def api_to_mongodb():
    """
    Summary: Get information from generic API into MongoDB. Confirm
        the information is uploaded.
    """

    max_results = 10
    mongo_obj = mongodb.MongoDB()

    json_data = _api_collect_json(max_results)
    logging.info(json_data)

    database = "APIData"
    collection = "user"
    mongo_obj.upload_bulk(database=database, collection=collection, document=json_data)

    search = {"gender": "male"}
    document = mongo_obj.select_data(database=database, collection=collection, search=search)
    logging.info(document)




def main():  
    """
    Summary: use with a sys.arg. e.g. "python3 main.py create"
    """
    command = sys.argv[1]  # command to only accept one argument

    if command == "create":
        api_to_mongodb()
    else:
        logging.exception("Only use commands:\ncreate\n\nTry again with a matching command.")


if __name__ == '__main__':
    main()