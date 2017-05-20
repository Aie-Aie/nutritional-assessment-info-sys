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
    return render_template('signin.html')
	
@app.route('/entries')
def getfocal():
	res = spcall('getfocal', ())
	
	if 'Error' in str(res[0][0]):
		

@app.route('/access', methods =['POST'])
def login():
    id= request.form['id']
    name =request.form['name']

    res =spcall("getaccess", (id, name), True)
    if 'Person not authorized' in res[0][0]:
        return render_template("signin.html")
    else:
        return render_template("dashboard.html")
    


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

