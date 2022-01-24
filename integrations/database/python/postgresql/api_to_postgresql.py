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

import postgres

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




def api_to_postgres():
    """
    Summary: get information from generic API into Postgresql.
    """

    max_results = 10
    data = _api_collect(max_results)

    logging.info("Starting creation...")
    pg_obj = postgres.Postgres()

    table_name = "user_table"
    schema = "dev"
    database = "devdb"

    sql = pg_obj.create_table_sql(data, schema, table_name)  # Create table statement
    pg_obj.create_schema(database, schema)  # Create the schema
    pg_obj.create_table(database, sql)  # Use the statement and execute.
    logging.info(data)
    pg_obj.upload_data(db_name=database, schema=schema, table=table_name, dataframe=data)  # Upload data



def main():  
    """
    Summary: use with a sys.arg. e.g. "python3 main.py create"
    """
    command = sys.argv[1]  # command to only accept one argument

    if command == "create":
        api_to_postgres()
    else:
        logging.exception("Only use commands:\ncreate\n\nTry again with a matching command.")


if __name__ == '__main__':
    main()