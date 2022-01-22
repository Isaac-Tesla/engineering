package database_java;

import java.sql.DriverManager
import java.sql.Connection
import java.sql.Statement

public class snowflake_create_table{
    public static void main(String args[]){
        val properties = new java.util.Properties()
        properties.put("user", "test")
        properties.put("password", "test")
        properties.put("account", "xxxxxx")
        properties.put("warehouse", "smallwh")
        properties.put("db", "testdb")
        properties.put("schema", "public")
        properties.put("role","ACCOUNTADMIN")

        String jdbcUrl = "jdbc:snowflake://xxxxxx.snowflakecomputing.com/"
        Connection connection = DriverManager.getConnection(jdbcUrl, properties)
        Statement statement = connection.createStatement()
        statement.executeUpdate("create or replace table PRODUCT(name VARCHAR, description VARCHAR, price NUMBER)")
        statement.close()
        connection.close()
    }
}
