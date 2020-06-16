# Container image that runs your code
FROM alpine:3.12.0
RUN apk add curl
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["sh","/entrypoint.sh"]
