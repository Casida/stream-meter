FROM python:3

WORKDIR /usr/src/smeter

COPY smflask .

RUN apt-get -y update

RUN pip3 install -r requirements.txt

EXPOSE 8080

ENTRYPOINT [ "python" ]

CMD ["run.py"]