from sqlalchemy import create_engine
import os

#some of the codes are from the tasks sample and re-implemented

class DBconnection:
    def __init__(self):
            engine =create_engine("postgres://postgres:postgres@127.0.0.1:5432/NAIS", echo=False)

