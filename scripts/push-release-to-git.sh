#!/bin/bash

git describe --always --tags
git config --global push.default simple
git push --tags