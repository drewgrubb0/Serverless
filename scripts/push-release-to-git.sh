#!/bin/bash

NEW_TAG=${NEW_TAG}

TAG=$(git describe --always --tags)
echo "Current tag: ${TAG}"

if [ -z ${NEW_TAG} ]; then
    echo "No new tag has been created. Exiting..."
    exit 1
fi

if [ "${TAG}" == "${NEW_TAG}" ]; then
    echo "Tag is not being incremented. Exiting..."
    exit 1
fi

git config --global push.default simple
git push --tags

if [[ $? -ne 0 ]]; then
    echo "Unable to push new tag, removing tag then exiting"
    git tag -d ${NEW_TAG}
    git push --tags
    exit 1
fi