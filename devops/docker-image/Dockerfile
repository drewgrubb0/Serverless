FROM python:3.6-alpine

WORKDIR /opt

RUN apk add curl jq && \
    apk add --update nodejs nodejs-npm

RUN npm install serverless-python-requirements && \
    npm install serverless
