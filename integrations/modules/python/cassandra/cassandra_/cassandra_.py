import json
import os
import logging
from enum import Enum
from cassandra.cluster import Cluster



class CassandraCredentials(Enum):
    """
    Class Notes
    -----------
     - Collects specified environment variables.
    
    Environment variables expected are:
    - user
    - password
    - port
    - host
    - keyspace
    - cluster

    """
    user = os.getenv['user']
    password = os.getenv['password']
    port = os.getenv['port']
    host = os.getenv['host']
    keyspace = os.getenv['keyspace']
    cluster = os.getenv['cluster']



class Cassandra():
    """
    Class Notes
    -----------
     - Using envrionment variables creates a connection to the
        Cassandra instance. Runs commands against the instance
        based on methods.

    To fix:
    -------
     - Add more methods.

    """

    def __init__(self):
        self.user = CassandraCredentials.user.value
        self.password = CassandraCredentials.password.value
        self.port = CassandraCredentials.port.value
        self.host = CassandraCredentials.host.value
        self.keyspace = CassandraCredentials.keyspace.value
        self.cluster = CassandraCredentials.cluster.value


    def _engine(self):
        try:
            cluster = Cluster([self.cluster])
            session = cluster.connect()
            return session
        except Exception:
            logging.error(f"\n\n ERROR: Missing information to create Cassandra engine.")
            raise


    def execute(self, sql):
        session = self._engine()
        try:
            session.execute(sql)
        except Exception:
            logging.error(f"\n\n ERROR: There was an issue executing code...\n {Exception}")
            raise
        finally:
            session.close()
        return f"SQL executed."