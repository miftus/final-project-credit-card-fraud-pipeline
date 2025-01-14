# First-time build can take upto 4 mins.
FROM apache/airflow:latest

ENV AIRFLOW_HOME=/opt/airflow

# COPY /.google .
COPY /service-account.json .
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

# Ref: https://airflow.apache.org/docs/docker-stack/recipes.html

# SHELL ["/bin/bash", "-o", "pipefail", "-e", "-u", "-x", "-c"]

# USER root
# RUN apt-get update && apt-get install wget
# USER airflow

WORKDIR $AIRFLOW_HOME

# COPY scripts scripts
# RUN chmod +x scripts

USER $AIRFLOW_UID

ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
USER root
RUN apt update -y
RUN apt upgrade -y
RUN apt install default-jdk -y
RUN apt install git -y
USER airflow
RUN pip install pyspark
RUN pip install dbt-bigquery
RUN pip install pandas
RUN pip install scikit-learn
RUN pip install joblibspark