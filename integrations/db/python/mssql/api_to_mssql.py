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

import mssql

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



def api_to_mssql():
    """
    Summary: get information from generic API into MSSQL.
    """

    max_results = 10
    data = _api_collect(max_results)

    logging.info("Starting creation...")
    mssql_obj = mssql.MSSQL()

    schema = "test"
    table_name = "fake_users"
    mssql_obj.execute("SELECT @@version;")
    mssql_obj.create_schema(schema)

    sql = mssql_obj.create_table_sql(dataframe=data, schema=schema, table_name=table_name)

    mssql_obj.create_table(sql)
    mssql_obj.append(data=data, schema=schema, table=table_name)


def main():  
    """
    Summary: use with a sys.arg. e.g. "python3 main.py create"
    """
    command = sys.argv[1]  # command to only accept one argument

    if command == "create":
        api_to_mssql()
    else:
        logging.exception("Only use commands:\ncreate\n\nTry again with a matching command.")


if __name__ == '__main__':
    main()