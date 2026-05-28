#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROUTER_IMAGE="${ROUTER_IMAGE:-sandbox-router:kind}"

if [[ -n "${KIND_CLUSTER:-}" ]]; then
  cluster="${KIND_CLUSTER}"
else
  cluster="$(kind get clusters | head -n1)"
fi

if [[ -z "${cluster}" ]]; then
  echo "No running kind cluster found. Set KIND_CLUSTER or create one first." >&2
  exit 1
fi

echo "==> Building router image: ${ROUTER_IMAGE}"
docker build -t "${ROUTER_IMAGE}" "${SCRIPT_DIR}"

echo "==> Loading image into kind cluster: ${cluster}"
kind load docker-image "${ROUTER_IMAGE}" --name "${cluster}"

echo "==> Applying sandbox router manifest"
export ROUTER_IMAGE
sed -E 's|^([[:space:]]*)image:.*$|\1image: ${ROUTER_IMAGE}|' "${SCRIPT_DIR}/sandbox_router.yaml" \
  | envsubst \
  | kubectl apply -f -

echo "==> Deployed sandbox router"
echo "kubectl get deploy sandbox-router-deployment"
echo "kubectl get pods -l app=sandbox-router"

