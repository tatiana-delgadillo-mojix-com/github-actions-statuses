# Container image that runs your code
FROM python:3.9.0b3-alpine
COPY entrypoint.sh entrypoint.sh
#arguments from github will be concatenated
ENTRYPOINT ["entrypoint.sh"]
