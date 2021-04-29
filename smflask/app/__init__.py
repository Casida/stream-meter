from flask import Flask, render_template
from flask_sqlalchemy import SQLAlchemy

# Shared Flack application object.
app = Flask(__name__)

# Configurations
app.config.from_object('config')

# Define database object to be imported.
db = SQLAlchemy(app)

# Very basic 404 handler.
@app.errorhandler(404)
def not_found(error):
    return render_template('404.html'), 404

# Default route message
@app.route('/')
def baseOutput():
  return "Stream Meter is running."

# Status message
@app.route('/status')
def statusOutput():
  return "Database: OK<br>\
          Site: OK<br>\
          RT: OK"

# Import our auth module.
from app.mod_auth.controllers import mod_auth as auth_module

# Blueprints for DB
app.register_blueprint(auth_module)

# Build all the database!
db.create_all()
