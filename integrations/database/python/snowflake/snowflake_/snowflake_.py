#!/usr/bin/python

import snowflake.connector
from snowflake.connector.pandas_tools import write_pandas
import json
import os
import logging
import numpy as np
import pandas as pd
import pandas.io.sql as sqlio
from io import StringIO
from enum import Enum



class SnowflakeCredentials(Enum):
    """
    Class Notes
    -----------
     - Collects specified environment variables.
    
    Environment variables expected are:
    - account
    - user
    - password

    """
    account = os.getenv('SNOWFLAKE_URL')
    user = os.getenv('SNOWFLAKE_USER')
    password = os.getenv('SNOWFLAKE_PASSWORD')



class Snowflake_():

    def __init__(self):
        self.account = SnowflakeCredentials.account.value
        self.user = SnowflakeCredentials.user.value
        self.password = SnowflakeCredentials.password.value
        

    def _engine(self, warehouse=None, database=None, schema=None) -> snowflake.connector:
        try:
            conn = snowflake.connector.connect(
                    user=self.user,
                    password=self.password,
                    account=self.account
                )
            if warehouse != None:
                conn.cursor().execute(f"USE WAREHOUSE {warehouse}")
            
            if database != None:
                conn.cursor().execute(f"USE DATABASE {database}")
            
            if schema != None:
                conn.cursor().execute(f"USE SCHEMA {schema}")
            return conn
        except Exception:
            logging.exception(f"\n\n ERROR: Missing information to create Snowflake engine.")
            raise        


    def execute(self, sql, warehouse, database, schema):
        engine = self._engine(warehouse=warehouse, database=database, schema=schema)
        try:
            engine.cursor().execute(sql)
        except Exception:
            logging.exception(f"\n\n ERROR: There was an issue executing code...")
            raise
        finally:
            engine.cursor().close()
            engine.close()
        return f"SQL executed: {sql}."


    def test_connection(self, warehouse, database, schema):
        sql = "SELECT current_version()"
        try:
            self.execute(sql, warehouse, database, schema)
            logging.info(f"Connection SUCCESS! for {warehouse}.{schema}.{database}")
        except Exception:
            logging.exception(f"\n\n testConnection failed!")
            raise


    def create_database(self, warehouse, database):
        try:
            self.execute(f"CREATE OR REPLACE DATABASE {database}", warehouse, database=None, schema=None)
            logging.info(f"Database creation SUCCESS! for {warehouse}.{database}")
        except Exception:
            logging.exception(f"\n\n createDatabase failed!")
            raise


    def drop_database(self, warehouse, database):
        try:
            self.execute(f"DROP DATABASE {database}", warehouse, database=None, schema=None)
            logging.info(f"Database creation SUCCESS! for {warehouse}.{database}")
        except Exception:
            logging.exception(f"\n\n dropDatabase failed!")
            raise


    def create_schema(self, warehouse, database, schema):
        try:
            self.execute(f"CREATE OR REPLACE SCHEMA {schema}", warehouse, database, schema=None)
            logging.info(f"Schema creation SUCCESS! for {warehouse}.{schema}.{database}")
        except Exception:
            logging.exception(f"\n\n createSchema failed!")
            raise


    def drop_schema(self, warehouse, database, schema):
        try:
            self.execute(f"DROP SCHEMA {schema}", warehouse, database, schema=None)
            logging.info(f"Schema creation SUCCESS! for {warehouse}.{schema}.{database}")
        except Exception:
            logging.exception(f"\n\n dropSchema failed!")
            raise


    def dtype_mapping(self):
        return {'object' : 'TEXT',
            'int64' : 'INT',
            'float64' : 'FLOAT',
            'datetime64' : 'DATETIME',
            'bool' : 'INT',
            'category' : 'TEXT',
            'timedelta[ns]' : 'DATETIME'}


    def create_table_from_dataframe(self, dataframe, table_name, warehouse, database, schema):

        snowflake_sql = f"CREATE OR REPLACE TABLE {table_name}("

        for i in range(0, len(list(dataframe.columns))):
            attr = list(dataframe.columns)[i]
            dmap = self.dtype_mapping()
            d_type = list(dataframe.dtypes)[i]
            snowflake_sql = snowflake_sql + f"\"{attr}\" {dmap[str(d_type)]}, "

        snowflake_sql = snowflake_sql[:-2] + ")"  

        logging.info(snowflake_sql)

        try: 
            self.execute(snowflake_sql, warehouse, database, schema)
            logging.info(f"Table created. {warehouse}.{schema}.{database}.{table_name}")
        except Exception:
            logging.exception(f"\n\n ERROR: Couldn't create the table.")
            raise


    def upload_from_dataframe_to_table(self, dataframe, table_name, warehouse, database, schema):

        engine = self._engine(warehouse=warehouse, database=database, schema=schema)

        # dataframe.columns = dataframe.columns.str.upper()

        try: 
            logging.info(f"Starting data upload...")
            write_pandas(engine, dataframe, table_name)
            logging.info(f"Data upload SUCCESS. {warehouse}.{schema}.{database}.{table_name}")
        except Exception:
            logging.exception(f"\n\n ERROR: Couldn't upload the data to table. {warehouse}.{schema}.{database}.{table_name}")
            raise


    def drop_table(self, warehouse, database, schema, table_name):
        try:
            self.execute(f"DROP TABLE {table_name}", warehouse, database, schema=None)
            logging.info(f"Schema creation SUCCESS! for {warehouse}.{schema}.{database}")
        except Exception:
            logging.exception(f"\n\n dropTable failed!")
            raise


    def select_data(self, warehouse, database, schema, table):

        engine = self._engine(warehouse=warehouse, database=database, schema=schema)
        sql = f"SELECT * FROM {table}"
        try:
            cur = engine.cursor()
            cur.execute(sql)
            dataframe = cur.fetch_pandas_all()
        except Exception:
            logging.exception(f"\n\n ERROR: There was an issue executing code...")
            raise
        finally:
            cur.close()
        return dataframe