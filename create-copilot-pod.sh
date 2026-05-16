#!/bin/bash

set -a
source .env
set +a
envsubst < k8s/copilot-pod.tmpl.yaml | kubectl apply -f -