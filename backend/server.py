
from flask import Flask, jsonify, request 
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

@app.route('/profiles/<name>', methods = ['GET'])
def getProfile(name):
    if(request.method == 'GET'): 
        a = {
            'fullname': name,
            'address': "aaa",
            'phoneNumber': "aaa",
        }

        return jsonify(a)
    
@app.route('/profiles/<name>/families', methods = ['GET'])
def getFamilyProfile(name):
    if(request.method == 'GET'): 
        a = {
            'fullname': name,
            'address': "bbb",
            'phoneNumber': "bbb",
        }
        print("got requesnt1")
        return jsonify(a)

@app.route('/meetings/<name>', methods = ['GET'])
def getDates(name):
    if(request.method == 'GET'): 
        a = [('ccc', '25.2'),
            ('ccc', '19.1'),
            ('ccc', '14')],
        print("got requesnt23")
        return jsonify(a)

if __name__ == '__main__':
   app.run(debug=True)