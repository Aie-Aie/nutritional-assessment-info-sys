# author: Ailen Aspe

from flask import Flask, jsonify, request
from database import DBconnection
from flask_httpauth import HTTPBasicAuth
from flask import render_template, redirect, url_for, session, flash
import sys, flask, os
import warnings
from flask.exthook import ExtDeprecationWarning

app = Flask (__name__)
auth = HTTPBasicAuth ()


def spcall(query, param, commit=False):
    try:
        dbo = DBconnection ()
        cursor = dbo.getcursor ()
        cursor.callproc (query, param)
        res = cursor.fetchall ()

        if commit:
            dbo.dbcommit ()
        return res

    except:
        res = [("Error: " + str (sys.exc_info ()[0]) + " " + str (sys.exc_info ()[1]),)]

    return res


@app.route ('/')
def index():
    return "HI"

#search
@app.route('/focaldata/<string:data>', methods=['GET'])
def searchfocal(data):

	res =spcall('searchfocal',(data,), True)
	print res
	if 'Error' in str(res[0][0]):
		return jsonify({'status':'error', 'message':res[0][0]})
	
	recs=[]
	for r in res:
		recs.append({"fname": r[0], "lname": r[1], "position": str(r[2])})
	
	return jsonify({'status':'ok', 'entries':recs, 'count':len(recs)})
	
	
	

# view existing focals
@app.route ('/focalentries', methods=['GET'])
def getfocal():
    res = spcall ('getfocal', ())

    if 'Error' in str (res[0][0]):
        return jsonify ({'status': 'error', 'message': res[0][0]})
    recs = []

    for r in res:
        recs.append ({"id": r[0], "first_name": r[1], "last_name": r[2], "position": r[3]})
    return jsonify ({'status': 'ok', 'entries': recs, 'count': len (recs)})



#view child data
@app.route('/childentries', methods=['GET'])
def getchildren():
	res= spcall('getchildren', ())
	
	recs=[]
	if 'Error' in str(res[0][0]):
		return jsonify({'status':'ok', 'message':res[0][0]})
	for r in res:
		recs.append({"id":r[0], "first_name":r[1], "last_name":r[2], "weight":r[3], "height":r[4],  "status":r[5]})
	
	return jsonify({'status':'ok', 'entries':recs, 'count':len(recs)})

@app.route('/access', methods=['POST'])
def login():
    id = request.form['id']
    name = request.form['name']

    res = spcall ("getaccess", (id, name), True)
    if 'Person not authorized' in res[0][0]:
        return render_template ("signin.html")
    else:
        return render_template ("dashboard.html")
		
#statistics
@app.route('/stat', methods=["GET"])
def showchildstat():
	
	res =spcall('countstat', 'Obesity', True)
	return jsonify({'status':'ok', 'result':res[0]})
	
	
# new focal added
@app.route ('/focal', methods=['POST'])
def addfocal():
    fid = request.form['id']
    lname = request.form['lname']
    fname = request.form['fname']
    pos = request.form['pos']
    res = spcall ("newemployee", (fid, lname, fname, pos), True)
    if 'Employee Exists' in res[0][0]:
        return jsonify ({'status': 'error', 'message': res[0][0]})

    return jsonify ({'status': 'ok', 'message': res[0][0]})

#add new child

@app.route('/child', methods=['POST'])
def addchild():
    childid = request.form['childid']
    childlname = request.form['childlname']
    childfname = request.form['childfname']
    childweight = request.form['weight']
    childheight =request.form['height']

    res =spcall("newchild2", (childid, childfname, childlname, childweight, childheight), True)
    if 'Child exists' in res[0][0]:
        return jsonify ({'status':'error', 'message':res[0][0]})
    return jsonify({'status':'ok', 'message':res[0][0]})


@app.after_request
def add_cors(resp):
    resp.headers['Access-Control-Allow-Origin'] = flask.request.headers.get('Origin', '*')
    #resp.headers['Access-Control-Allow-Origin'] = flask.request.headers.get ('Origin')
    resp.headers['Access-Control-Allow-Credentials'] = True
    resp.headers['Access-Control-Allow-Methods'] = 'POST, OPTIONS, GET, PUT, DELETE'
    resp.headers['Access-Control-Allow-Headers'] = flask.request.headers.get ('Access-Control-Request-Headers',
                                                                          'Authorization')
    # set low for debugging

    if app.debug:
        resp.headers["Access-Control-Max-Age"] = '1'
    return resp


if __name__ == '__main__':
    app.run (debug=True)
