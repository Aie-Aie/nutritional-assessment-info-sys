#author: Ailen Aspe

from flask import Flask, jsonify,request
from database import DBconnection
from flask_httpauth import HTTPBasicAuth
from flask import render_template, redirect, url_for, session, flash
import sys, flask, os
import warnings
from flask.exthook import ExtDeprecationWarning

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
    return "HI"
	

@app.route('/focalentries', methods=['GET'])
def getfocal():
	res = spcall('getfocal', ())
	
	if 'Error' in str(res[0][0]):
		return jsonify({'status':'error', 'message':res[0][0]})
	recs=[]
	
	for r in res:
		recs.append({"id":r[0], "first_name":r[1], "last_name":r[2], "position":r[3]})
	return jsonify({'status':'ok', 'entries':recs, 'count':len(recs)})
		
		
		

@app.route('/access', methods =['POST'])
def login():
    id= request.form['id']
    name =request.form['name']

    res =spcall("getaccess", (id, name), True)
    if 'Person not authorized' in res[0][0]:
        return render_template("signin.html")
    else:
        return render_template("dashboard.html")

@app.route('/focal', methods =['POST'])
def addfocal():
	


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

