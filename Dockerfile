# Container image that runs your code
FROM python:3.9.0b3-alpine
COPY main.py /main.py
#arguments from github will be concatenated
ENTRYPOINT ["python","main.py"]
