#!/usr/bin/env bash

docker build -t frontend-ci .
docker tag frontend-ci bohushvitali/frontend-ci:latest
docker push bohushvitali/frontend-ci:latest