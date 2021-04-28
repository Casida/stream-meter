from flask_wtf import Form

# Import elements
from wtforms import TextField, PasswordField

# Import field validation
from wtforms.validators import Required, Email, EqualTo

# Login form

class LoginForm(Form):
    email    = TextField('Email Address', [Email(),
                Required(message='Email address required.')])
    password = PasswordField('Password', [
                Required(message='Password required.')])