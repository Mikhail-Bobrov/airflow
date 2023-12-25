FROM apache/airflow:2.7.1

USER root

RUN apt-get update && apt-get install libgomp1 -y

USER airflow

COPY requirements.txt requirements.txt

RUN pip install -r requirements.txt
