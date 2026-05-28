#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IMAGE_NAME="simple-sandbox-image:dev"
KIND_CLUSTER="${KIND_CLUSTER:-kind}"

echo "==> Building Docker image: ${IMAGE_NAME}"
docker build -t "${IMAGE_NAME}" "${SCRIPT_DIR}"

echo "==> Loading image into kind cluster: ${KIND_CLUSTER}"
kind load docker-image "${IMAGE_NAME}" --name "${KIND_CLUSTER}"

echo "==> Applying manifest with IMAGE_NAME=${IMAGE_NAME}"
export IMAGE_NAME
envsubst < "${SCRIPT_DIR}/template.yaml" | kubectl apply -f -

echo "==> Done. Watch resources with:"
echo "    kubectl get sandboxtemplates -w"

