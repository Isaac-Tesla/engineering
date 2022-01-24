#!/usr/bin/python

import json
import logging
import pandas as pd
import pyodbc
from io import StringIO
import sqlalchemy
import urllib
import os
from enum import Enum



class MssqlCredentials(Enum):
    """
    Class Notes
    -----------
     - Collects specified environment variables.
    
    Environment variables expected are:
    - server
    - port
    - database
    - user
    - password

    """
    server = os.getenv['server']
    port = os.getenv['port']
    database = os.getenv['database']
    user = os.getenv['user']
    password = os.getenv['password']



class MSSQL():

    """
    Class Notes
    -----------
     - Using envrionment variables creates a connection to the
        MSSQL instance. Runs commands against the instance
        based on methods.

    To fix:
    -------
     - Add more methods.

    """

    def __init__(self):
        self.server = MssqlCredentials.server.value
        self.port = MssqlCredentials.port.value
        self.database = MssqlCredentials.database.value
        self.user = MssqlCredentials.user.value
        self.password = MssqlCredentials.password.value


    def engine(self):
        driver = "{ODBC Driver 17 for SQL Server}"
        connection_str = f"""DRIVER={driver};
                                SERVER={self.server};
                                DATABASE={self.database};
                                UID={self.user};
                                PWD={self.password};"""
        quoted = urllib.parse.quote_plus(connection_str)
        engine = sqlalchemy.create_engine('mssql+pyodbc:///?odbc_connect={}'.format(quoted))
        return engine


    def execute(self, sql):
        try:
            engine = self.engine()
            connection = engine.connect()
            transaction = connection.begin()
            logging.info(f"Connection established.")
        except Exception:
            logging.exception(f"There was an issue connecting to a database and starting new execute transaction")
            raise

        try:
            row_count = connection.execute(sql)
            row_count = row_count.rowcount
            transaction.commit()
            logging.info(f"SQL Executed.")
        except Exception:
            transaction.rollback()

            logging.exception(f"There was an issue executing sql query against digital data warehouse:\n{sql}")
            raise
        finally:
            connection.close()
        return row_count


    def create_schema(self, schema_name):
        try:
            sql = f"CREATE SCHEMA {schema_name};"
            engine = self.engine()
            engine.execute(sql)
            engine.commit()
            logging.info(f"createSchema complete.")
        except Exception:
            logging.exception(f"\n\n ERROR: There was an issue creating schema {schema_name}.")
            raise
        finally:
            engine.close()
        return f"Schema created."


    def create_table(self, sql):
        try:
            engine = self.engine()
            engine.execute(sql)
            engine.commit()
            logging.info(f"createTable complete.")
        except Exception:
            logging.exception(f"\n\n ERROR: There was an issue creating the table for database.")
            raise
        finally:
            engine.close()
        return f"Table created."


    def dtype_mapping(self):
        return {'object' : 'VARCHAR(MAX)',
            'int64' : 'BIGINT',
            'float64' : 'FLOAT',
            'datetime64' : 'DATETIME',
            'bool' : 'BOOLEAN',
            'timedelta[ns]' : 'DATETIME'}

    def create_table_sql(self, dataframe, schema, table_name):
        create_table_sql = f"CREATE TABLE {schema}.{table_name}("
        try:
            for i in range(0, len(list(dataframe.columns))):
                attr = list(dataframe.columns)[i]
                d_type = list(dataframe.dtypes)[i]
                dmap = self.dtype_mapping()
                create_table_sql = create_table_sql + f"\"{attr}\" {dmap[str(d_type)]}, "
                
                if (i+1) == len(list(dataframe.columns)):
                    create_table_sql = create_table_sql[:-2] + f");"

            logging.info(create_table_sql)
        except Exception:
            logging.error(f"\n\n ERROR: There was an issue making the create table statement for {schema}.{table_name}")
            logging.info(create_table_sql)
            raise

        return create_table_sql



    def append(self, data, schema, table):
        try:
            engine = self.engine()
            connection = engine.connect()
            transaction = None
        except Exception:
            logging.exception(f"There was an issue connecting to a database")
            raise

        try:
            if len(data) == 0:
                logging.info(f"No data. Nothing to append to {schema}.{table}")
                return
            transaction = connection.begin()

            if "id" in data and data["id"].count() < len(data):
                data = data.drop("id", axis=1)

            data.to_sql(
                f"{table}",
                self.engine(),
                schema=schema,
                chunksize=10000,
                if_exists="append",
                index=False,
                method=None,
            )
            transaction.commit()
            logging.info(f"Appended {len(data)} rows to {schema}.{table} table")
        except Exception:
            if transaction is not None:
                transaction.rollback()
            logging.exception(
                f"There was an issue trying to append {len(data)} rows to {schema}.{table}")
            raise
        finally:
            connection.close()