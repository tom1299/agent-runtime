#!/bin/bash

set -a
source .env
set +a
envsubst < k8s/opencode-pod.tmpl.yaml | kubectl apply -f -