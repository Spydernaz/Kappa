FROM python:3.7

RUN pip install confluent-kafka

COPY data/ /data/
COPY app/app.py /app.py

ENTRYPOINT [ "python", "/app.py" ]