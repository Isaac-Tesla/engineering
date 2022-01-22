package database_java;

import com.mongodb.MongoCommandException;
import com.mongodb.client.MongoClients;
import com.mongodb.client.MongoCollection;
import org.bson.Document;

import java.util.ArrayList;

public class mongo_create_collection {

    public static void main(String[] args) {

        try (var mongoClient = MongoClients.create("mongodb://localhost:27017")) {

            var database = mongoClient.getDatabase("productdb");

            try {

                database.createCollection("products");
            } catch (MongoCommandException e) {

                database.getCollection("products").drop();
            }

            var docs = new ArrayList<Document>();

            MongoCollection<Document> collection = database.getCollection("products");

            var d1 = new Document("_id", 1);
            d1.append("name", "Shoe");
            d1.append("price", 52);
            docs.add(d1);

            var d2 = new Document("_id", 2);
            d2.append("name", "Hat");
            d2.append("price", 5);
            docs.add(d2);

            var d3 = new Document("_id", 3);
            d3.append("name", "Skirt");
            d3.append("price", 90);
            docs.add(d3);

            var d4 = new Document("_id", 4);
            d4.append("name", "Dress");
            d4.append("price", 290);
            docs.add(d4);

            var d5 = new Document("_id", 5);
            d5.append("name", "Shirt");
            d5.append("price", 35);
            docs.add(d5);

            var d6 = new Document("_id", 6);
            d6.append("name", "Beanie");
            d6.append("price", 20);
            docs.add(d6);

            var d7 = new Document("_id", 7);
            d7.append("name", "Socks");
            d7.append("price", 4);
            docs.add(d7);

            var d8 = new Document("_id", 8);
            d8.append("name", "Jumper");
            d8.append("price", 85);
            docs.add(d8);

            collection.insertMany(docs);
        }
    }
}