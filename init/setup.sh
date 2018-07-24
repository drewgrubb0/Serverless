#!/usr/bin/env bash

chmod +x ./test/test.sh
chmod +x ./test/test-remote.sh

serverless create --template aws-python3
git init
virtualenv venv --python=python3
source venv/bin/activate
pip freeze > requirements.txt
npm init
npm install --save serverless-python-requirements