#author: Ailen Aspe

from flask import Flask, jsonify
from database import DBconnection
import flask
import sys

app = Flask(__name__)
auth = HTTPBasicAuth()

def spcall(query, param, commit=False):
	try:
		dbo=DBconnection()
		cursor=dbo.getcursor()
		cursor.callproc(query, param)
		res = cursor.fetchall()
		
		if commit:
			dbo.dbcommit()
		return res
	
	except:
		res = [("Error: " +str(sys.exc_info()[0]) + " " +str(sys.exc_info()[1]),)]

	return res

@app.route('/')
def index():
	return "Still Confused"

@app.route('/focal', methods=['POST'])
def insertfocal():
	id=request.form['id']
	fname = request.form['fname']
	lname = request.form['lname']
	designation = request.form['designation']
	
	res = spcall("newfocal", (id, fname, lname, designation), True)
	
	if 'Error' in res[0][0]:
		return jsonify({'status': 'error', 'message': res[0][0]})
	return jsonify({'status': 'ok', 'message':res[0][0]})
	


@app.after_request
def add_cors(resp):
    resp.headers['Access-Control-Allow-Origin'] = flask.request.headers.get('Origin', '*')
    resp.headers['Access-Control-Allow-Credentials'] = True
    resp.headers['Access-Control-Allow-Methods'] = 'POST, OPTIONS, GET, PUT, DELETE'
    resp.headers['Access-Control-Allow-Headers'] = flask.request.headers.get('Access-Control-Request-Headers',
                                                                             'Authorization')
    # set low for debugging

    if app.debug:
        resp.headers["Access-Control-Max-Age"] = '1'
    return resp

if __name__ == '__main__':
    app.run(debug=True)

	
	

