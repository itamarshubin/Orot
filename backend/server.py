
from flask import Flask, jsonify, request 
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

@app.route('/', methods = ['GET'])
def getProfile():
    if(request.method == 'GET'): 
        a = {
            'fullname': "aaa",
            'address': "aaa",
            'phoneNumber': "aaa",
        }
        print("got requesnt")
        return jsonify(a)

if __name__ == '__main__':
   app.run(debug=True)