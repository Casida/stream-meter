FROM python:3
WORKDIR /usr/src/app
COPY flask/* .
RUN apt-get -y update
RUN pip3 install -r requirements.txt
EXPOSE 5000
ENTRYPOINT FLASK_APP=/usr/src/app/baseapp.py flask run --host=0.0.0.0