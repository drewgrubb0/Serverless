#!/bin/bash
#
# Retrieves current release tag from github and increments it using SemVer before
# storing the new value in the environment variable NEW_TAG.
# Tags are released and incremented in a 0.0.0 fashion.
#
# Parameters: VERSION_INCREMENT ["none", "patch", "minor", "major"] : Default patch

ROOT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

if [ "${VERSION_INCREMENT}" == "none" ]; then
    echo "Not releasing a new tag. Exiting..."
    exit 1
fi

CURRENT_COMMIT=$(git rev-parse HEAD)
echo "Acting on commit ${CURRENT_COMMIT}"

CURRENT_TAG=$(git describe $(git rev-list --tags --max-count=1) --tags)

if [[ $? -ne 0 ]]; then
    echo "No tag exists. Using default tag 0.0.1"
    NEW_TAG="0.0.1"
else
    CURRENT_TAG_COMMIT=$(git rev-list -n 1 ${CURRENT_TAG})
    echo "Current tag ${CURRENT_TAG} on commit ${CURRENT_TAG_COMMIT}"
fi

if [[ "${CURRENT_COMMIT}" == "${CURRENT_TAG_COMMIT}" ]]; then
    echo "No changes to be pushed. Exiting..."
    exit 1
fi

git diff-index --quiet HEAD --
if [[ $? -ne 0 ]]; then
    echo "There are uncommitted changes on the current branch. Exiting..."
    exit 1
fi

if [ -z "${VERSION_INCREMENT}" ];then
    echo "No version increment set. incrementing by \"patch\""
    VERSION_INCREMENT="patch"
fi

mkdir -p "${ROOT_DIR}/tmp/tagging"

echo "Downloading semver..."
SEMVER_FILE="${ROOT_DIR}/tmp/semver"
if [ ! -f "${SEMVER_FILE}" ]; then
    curl -o "${SEMVER_FILE}" https://raw.githubusercontent.com/fsaintjacques/semver-tool/2.0.0/src/semver
    chmod +x "${SEMVER_FILE}"
fi

if [ $? -ne 0 ]; then
    echo "Error downloading SemVer. Exiting..."
    exit 1
fi

if [ ! -f "${SEMVER_FILE}" ]; then
    echo "Semver file not downloaded/found. Exiting..."
    exit 1
fi

if [ "${NEW_TAG}" != "0.0.1" ]; then
    NEW_TAG=$("${SEMVER_FILE}" bump ${VERSION_INCREMENT} ${CURRENT_TAG})
fi

echo "New tag is ${NEW_TAG}"
echo "${NEW_TAG}" > "${ROOT_DIR}/version.txt"

git tag ${NEW_TAG}
echo "Tag successfully created."

rm -rf "${ROOT_DIR}/tmp/tagging"