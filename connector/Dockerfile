FROM python:3.5

RUN apt-get update

RUN apt-get install git

COPY requirements.txt /tmp/connector/requirements.txt

RUN pip install -r /tmp/connector/requirements.txt

CMD ["bash", "/tmp/connector/run-connector.sh"]
