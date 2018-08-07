FROM python:3.6-alpine

WORKDIR /opt

RUN apk add curl jq sudo shadow && \
    apk add --update nodejs nodejs-npm

RUN npm install serverless-python-requirements && \
    npm install serverless

USER root

ENV GROUP_ID=500 \
    GROUP_NAME=jenkins \
    USER_ID=500 \
    USER_NAME=jenkins

RUN groupadd -g ${GROUP_ID} ${GROUP_NAME} && \
    useradd -g ${GROUP_ID} -u ${USER_ID} ${USER_NAME} && \
    usermod -aG wheel ${USER_NAME} && \
    echo "%wheel    ALL=(ALL)   NOPASSWD: ALL" >> "/etc/sudoers"

USER ${USER_NAME}}