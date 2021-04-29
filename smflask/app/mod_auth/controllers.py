from flask import Blueprint, request, render_template, \
                  flash, g, session, redirect, url_for

# Encryption helpers
from werkzeug.security import check_password_hash, generate_password_hash

# Internal DB module
from app import db

# Import forms
from app.mod_auth.forms import LoginForm

# Import User DB model
from app.mod_auth.models import User

# Blueprint for auth URL: domain.url/auth
mod_auth = Blueprint('auth', __name__, url_prefix='/auth')

# Route and methods defs
@mod_auth.route('/signin/', methods=['GET', 'POST'])
def signin():

    # Submit call.
    form = LoginForm(request.form)

    # Validate entries.
    if form.validate_on_submit():

        user = User.query.filter_by(email=form.email.data).first()

        if user and check_password_hash(user.password, form.password.data):

            session['user_id'] = user.id

            flash('Welcome %s' % user.name)

            return redirect(url_for('auth.home'))

        flash('Wrong email address or password.', 'error-message')

    return render_template("auth/signin.html", form=form)