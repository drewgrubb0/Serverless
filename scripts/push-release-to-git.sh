#!/bin/bash

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
NEW_TAG=$(<"${ROOT_DIR}/version.txt")

TAG=$(git describe --always --tags)
echo "Current tag: ${TAG}"
echo "New tag: ${NEW_TAG}"

if [ -z ${NEW_TAG} ]; then
    echo "No new tag has been created. Exiting..."
    exit 1
fi

if [ "${TAG}" == "${NEW_TAG}" ]; then
    echo "Tag is not being incremented. Exiting..."
    exit 0
fi

git tag "${NEW_TAG}"
echo "Tag successfully created."

git config --global push.default simple
git push --tags

if [[ $? -ne 0 ]]; then
    echo "Unable to push new tag, removing tag then exiting"
    git tag -d ${NEW_TAG}
    git push --tags
    exit 1
fi