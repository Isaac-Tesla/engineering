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

import cassandra_

root_dir = Path(__file__).parent.absolute()


def _api_collect(self, max_results: int) -> pd.DataFrame:
    """
    Summary:
        Collects a set number of results from a public API.

    Returns:
        [Pandas dataframe]: A dataframe consisting of flattened
            results from a public JSON API for users.

    """
    base = pd.DataFrame()
    for i in range(0, max_results):
        response = requests.get("https://randomuser.me/api/")
        response.encoding = 'utf-8'
        response.json()
        flattened_json = json_normalize(response.json()['results'])
        base = pd.concat([base, flattened_json])

    return base.reset_index(drop=True)



def api_to_cassandra():
    """
    Summary: Get information from generic API into 
        a dataframe, create tables in Cassandra.
    """

    logging.info("Starting creation...")
    cass_obj = cassandra_.Cassandra()

    max_results = 3
    data = _api_collect(max_results)
    logging.info(data.head())

    SQL1 = """CREATE KEYSPACE demo WITH replication = {'class': 'SimpleStrategy', 'replication_factor': '1'}"""
    SQL2 = """CREATE TABLE demo.users (lastname text PRIMARY KEY, firstname text, email text); """

    cass_obj._cass.execute(SQL1)
    cass_obj._cass.execute(SQL2)



def main():  
    """
    Summary: use with a sys.arg. e.g. "python3 main.py create"
    """
    command = sys.argv[1]  # command to only accept one argument

    if command == "create":
        api_to_cassandra()
    else:
        logging.exception("Only use commands:\ncreate\n\nTry again with a matching command.")


if __name__ == '__main__':
    main()