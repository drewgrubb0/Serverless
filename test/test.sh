#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOT="$(cd $DIR && cd .. && pwd)"

cd $ROOT

FUNCTION=$1

if [ -z "$1" ]
then
    echo `date`" - Usage: ./test.sh [Function Path] (Input Data Path)"
    exit 1
fi

DEFAULT_INPUT_DATA="${DIR}/empty-data.json"
INPUT_DATA=${2:-$DEFAULT_INPUT_DATA}

serverless invoke local --function ${FUNCTION} --data INPUT_DATA