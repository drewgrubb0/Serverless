FROM python:3.6-alpine

WORKDIR /opt

RUN apk add curl jq sudo shadow && \
    apk add --update nodejs nodejs-npm

RUN npm install serverless-python-requirements && \
    npm install serverless

RUN useradd --uid 500 jenkins && \
    echo "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    groupadd docker && \
    usermod -aG docker jenkins

USER jenkins