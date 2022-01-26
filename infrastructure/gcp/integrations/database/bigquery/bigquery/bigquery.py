#!/usr/bin/python

import logging
import pandas as pd

from google.cloud import bigquery
from google.cloud.bigquery.job import LoadJobConfig, WriteDisposition
from google.cloud.exceptions import NotFound
from google.oauth2 import service_account



class BigQuery(object):
    """
    Summary:
        This class creates a connection to the BigQuery 
        instance and runs commands against the instance
        based on methods.

    """
    @classmethod
    def from_config(cls, config):
        project_id = config.gcp.project_id
        credentials_file_path = config.gcp.credentials_file_path

        bq = BigQuery(
            project_id,
            credentials_file_path
        )

        return bq


    def __init__(self, project_id, credentials_file_path):
        self._project_id = project_id
        self._credentials_file_path = credentials_file_path


    def engine(self):
        """
        Summary: Uses the downloaded credentials for the service 
            account to generate a connection object as an engine
            for the program to run off.

        Returns:
            [google.client]: A connection client for BigQuery.

        """
        credentials = service_account.Credentials.from_service_account_file(
            self._credentials_file_path,
            scopes=[
                "https://www.googleapis.com/auth/bigquery",
                "https://www.googleapis.com/auth/drive"
            ]
        )

        client = bigquery.Client(
            project=self._project_id,
            credentials=credentials
        )

        return client


    def execute(self, sql: str) -> pd.Dataframe:
        """
        Summary: Executes the SQL statement in BigQuery.

        Args:
            sql ([str]): The SQL string to run.

        Returns:
            [Pandas Dataframe]: Any output from the query.
                e.g. tables, results.

        """
        try:
            client = self.engine()
            df = client.query(sql).to_dataframe()
            return df
        except Exception:
            logging.exception(f"There was an issue running the SQL:\n{sql}")
            raise


    def append_dataframe(self, dataset_name: str, table_name: str, dataframe: pd.Dataframe, truncate=False, schema=None) -> None:
        """
        Summary: Appends a Pandas Dataframe object data 
            to the end of an existing table in BigQuery.

        Args:
            dataset_name ([str]): A string of the dataset name to append to.
            table_name ([str]): A string of the table name to append to.
            dataframe ([Dataframe]): A Pandas Dataframe object of data for appending.
            truncate (bool, optional): Flag for truncating the table. Defaults to True.
            schema ([str], optional): A schema (if required) for specification. Defaults to None.
        """
        try:
            client = self.engine()
            table_ref = client.execute(f"SELECT * FROM {dataset_name}.{table_name}")

            pos = WriteDisposition.WRITE_TRUNCATE if truncate else WriteDisposition.WRITE_APPEND
            job_config = LoadJobConfig(
                write_disposition=pos,
                schema=schema
            )

            job = client.load_table_from_dataframe(
                dataframe,
                table_ref,
                job_config=job_config
            )

            job.result()

            logging.info(f"Appended {len(dataframe)} rows to {dataset_name}.{table_name}.")
        except Exception:
            msg = f"There was an error appending data to {dataset_name}.{table_name}."
            logging.exception(msg)
            raise