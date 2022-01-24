#!/usr/bin/python

import pymongo
import json
import os
import logging
import pandas as pd
import pandas.io.sql as sqlio
from pymongo import MongoClient
from io import StringIO
from enum import Enum



class MongoDBCredentials(Enum):

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



class MongoDB():

    """
    Class Notes
    -----------
     - Using envrionment variables creates a connection to the
        MongoDB instance. Runs commands against the instance
        based on methods.

    To fix:
    -------
     - Add more methods.

    """

    def __init__(self):
        self.server = MongoDBCredentials.server.value
        self.port = MongoDBCredentials.port.value
        self.database = MongoDBCredentials.database.value
        self.user = MongoDBCredentials.user.value
        self.password = MongoDBCredentials.password.value


    def engine(self):
        """
        Summary:
        Creates a MongoDB client with the connection string.

        Returns:
            [MongoClient]: A MongoClient object used to connect.

        """
        return MongoClient(f"mongodb://{self.server}:{self.port}/")


    def upload_bulk(self, database: str, collection: str, document: json) -> None:
        """
        Summary:
        MongoDB can only create a new collection with an upload, this 
            function/method does both. Note a database will only be 
            created when there are 1+ documents being added.

        Args:
            database (str): name of the database to create.
            collection (str): name of the collection to create.
            document (json): a json file containing the records to upload.

        """

        logging.info(f"Uploading to database/collection {database}/{collection}...")
        
        try:
            client = self.engine()

            if len(document) > 0:
                with client:
                    db = client[database]
                    db[collection].insert_many(document)            
            else:
                logging.info(f"Document value zero, database/collection not created for {database}/{collection}.")

        except Exception:
            raise Exception(f"There was an issue uploading/creating the database {database}.")

        logging.info(f"Data uploaded to database/collection {database}/{collection}.")


    def upload_one(self, database: str, collection: str, document: json) -> None:
        """
        Summary:
        MongoDB can only create a new collection with an upload, this 
            function/method does both. Note a database will only be 
            created when there are 1+ documents being added. Unlike 
            the bulk upload this method only uploads a single json
            record.

        Args:
            database (str): name of the database to create.
            collection (str): name of the collection to create.
            document (json): a json file containing the records to upload.

        """

        logging.info(f"Uploading to database/collection {database}/{collection}...")
        
        try:
            client = self.engine()

            if len(document) > 0:
                with client:
                    db = client[database]
                    db[collection].insert_one(document)            
            else:
                logging.info(f"Document value zero, database/collection not created for {database}/{collection}.")

        except Exception:
            raise Exception(f"There was an issue uploading/creating the database {database}.")

        logging.info(f"Data uploaded to database/collection {database}/{collection}.")


    def list_databases(self) -> list:
        """
        Summary:
        Collects a list of the current databases in MongoDB and 
            returns the list.

        Returns:
            [list]: a list of the databases in MongoDB.

        """

        logging.info(f"Collecting list of databases...")

        try:
            client = self.engine()

            database_list = []

            for db in client.list_databases():
                database_list.append(db)

        except Exception:
            raise Exception(f"There was an issue collecting the list of databases.")

        logging.info(f"Database list collected.")

        return database_list



    def select_data(self, database: str, collection: str, search: str) -> json:
        """
        Summary:
        Selects and returns data from a MongoDB database/collection.

        Args:
            database (str): name of the database.
            collection (str): name of the collection to search.
            search (str): the index value to search for.

        Returns:
            json: [description]

        """

        logging.info(f"Selecting data...")

        try:
            client = self.engine()
            db = client[f"{database}"]
            col = db[f"{collection}"]
            data = col.find(search)

        except Exception:
            raise Exception(f"There was an issue selecting data.")

        logging.info(f"Data selected.")

        return data