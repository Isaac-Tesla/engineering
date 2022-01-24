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

pd.set_option('display.max_columns', None)

import snowflake_



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



def api_to_snowflake():
    """
    Summary: get information from generic API into Snowflake.
    """

    max_results = 10
    data = _api_collect(max_results)

    logging.info("Starting creation...")
    sf_obj = snowflake_.Snowflake_()
   

    # Upload to Snowflake
    warehouse = "COMPUTE_WH"
    database = "DEV_DB"
    schema = "DEV_DB.DEV_SCHEMA"
    table_name = "DEV_USER_TABLE"

    sf_obj.create_database(warehouse=warehouse, database=database)

    sf_obj.create_schema(warehouse=warehouse, 
                            database=database, 
                            schema=schema)

    # Create table
    sf_obj.create_table_from_dataframe(dataframe=data, 
                                        table_name=table_name, 
                                        warehouse=warehouse, 
                                        database=database, 
                                        schema=schema)

    # Upload the data to the new table
    sf_obj.upload_from_dataframe_to_table(dataframe=data,
                                        table_name=table_name,
                                        warehouse=warehouse,
                                        database=database, 
                                        schema=schema)


def select():

    warehouse = "COMPUTE_WH"
    database = "TESTDB_MG"
    schema = "TESTSCHEMA_MG"
    table_name = "TEST_FAKE_USERS"

    logging.info("Starting creation...")
    sf_obj = snowflake_.Snowflake_()

    data = sf_obj.selectData(warehouse=warehouse,
                                database=database,
                                schema=schema,
                                table=table_name)

    logging.info(data)


def main():  
    """
    Summary: use with a sys.arg. e.g. "python3 main.py create"
    """
    command = sys.argv[1]  # command to only accept one argument

    if command == "create":
        api_to_snowflake()
    elif command == "select":
        select()
    else:
        logging.exception("Only use commands:\ncreate\n\nTry again with a matching command.")


if __name__ == '__main__':
    main()