#!/usr/bin/env bash

serverless create --template aws-python3 --path drewgrubb-test-api
cd drewgrubb-test-api
git init
virtualenv venv --python=python3
source venv/bin/activate
pip freeze > requirements.txt
npm init
npm install --save serverless-python-requirements