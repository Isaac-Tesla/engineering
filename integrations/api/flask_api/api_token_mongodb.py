from pymongo import MongoClient
from flask_jwt_extended import JWTManager, jwt_required, create_access_token
from flask import Flask, jsonify, request

mongo = MongoClient("mongodb://localhost:27017/")
db = mongo["login_database"]
user = db["User"]


app = Flask(__name__)
jwt = JWTManager(app)
app.config["JWT_SECRET_KEY"] = "my-secret-key"


@app.route("/ui")
@jwt_required
def ui():
    return jsonify(message="User interface.")


@app.route("/adduser", methods=["POST"])
def adduser():
    username = request.form["username"]
    test = user.find_one({"username": username})
    if test:
        return jsonify(message="User Already Exist"), 409
    else:
        first_name = request.form["first_name"]
        last_name = request.form["last_name"]
        password = request.form["password"]
        user_info = dict(first_name=first_name, last_name=last_name, username=username, password=password)
        user.insert_one(user_info)
        return jsonify(message="User added sucessfully"), 201


@app.route("/login", methods=["POST"])
def login():
    if request.is_json:
        username = request.json["username"]
        password = request.json["password"]
    else:
        username = request.form["username"]
        password = request.form["password"]

    test = user.find_one({"username": username, "password": password})
    if test:
        access_token = create_access_token(identity=username)
        return jsonify(message="Login succeeded", access_token=access_token), 201
    else:
        return jsonify(message="Invalid username or password"), 401


if __name__ == '__main__':
    app.run(host="localhost", debug=True)