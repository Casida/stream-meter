DEBUG = True
import os
BASE_DIR = os.path.abspath(os.path.dirname(__file__))  

# SQLite config
SQLALCHEMY_DATABASE_URI = 'sqlite:///' + os.path.join(BASE_DIR, 'app.db')
DATABASE_CONNECT_OPTIONS = {}

THREADS_PER_PAGE = 2

# Cross-site Request Forgery (CSRF) protection.
CSRF_ENABLED     = True
CSRF_SESSION_KEY = "secret"
SECRET_KEY = "secret"
SQLALCHEMY_TRACK_MODIFICATIONS = False