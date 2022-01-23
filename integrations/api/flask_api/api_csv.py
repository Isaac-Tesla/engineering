from flask import Flask
from flask_restful import Resource, Api, reqparse
import pandas as pd
import ast


app = Flask(__name__)
api = Api(app)


class Customers(Resource):
    def get(self):
        data = pd.read_csv('customers.csv')
        data = data.to_dict()
        return {'data': data}, 200

    def post(self):
        parser = reqparse.RequestParser()
        parser.add_argument('custId', required=True)
        parser.add_argument('name', required=True)
        parser.add_argument('postcode', required=True)
        args = parser.parse_args()
        data = pd.read_csv('customers.csv')

        if args['custId'] in list(data['custId']):
            return {'message': f"'{args['custId']}' already exists."}, 409
        else:
            new_data = pd.DataFrame({
                'custId': [args['custId']],
                'name': [args['name']],
                'postcode': [args['postcode']],
                'saleIds': [[]]
            })
            data = data.append(new_data, ignore_index=True)
            data.to_csv('customers.csv', index=False)
            return {'data': data.to_dict()}, 200

    def delete(self):
        parser = reqparse.RequestParser()
        parser.add_argument('custId', required=True)
        args = parser.parse_args()
        data = pd.read_csv('customers.csv')

        if args['custId'] in list(data['custId']):
            data = data[data['custId'] != args['custId']]
            data.to_csv('customers.csv', index=False)
            return {'data': data.to_dict()}, 200
        else:
            return { 'message': f"'{args['custId']}' user not found." }, 404


api.add_resource(Customers, '/customers')


if __name__ == '__main__':
    app.run()