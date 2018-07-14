#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ROOT="$(cd $DIR && cd .. && pwd)"

cd $ROOT

FUNCTION=$0

if[[ -z $FUNCTION ]];
then
    echo `date`" - Usage: ./test.sh [Function Path] (Input Data Path)"
    exit 1
fi

DEFAULT_INPUT_DATA="${DIR}/empty-data.json"
INPUT_DATA=${1:-$DEFAULT_INPUT_DATA}

serverless invoke --function ${FUNCTION_PATH} --path ${INPUT_DATA}