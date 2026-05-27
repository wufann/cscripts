#!/bin/bash
# Run on the PREFILL node. Start this BEFORE P and D.
set -e
source "$(dirname "$0")/env.sh"

echo "Proxy listening on 0.0.0.0:${PROXY_HTTP_PORT} (HTTP)"
echo "Discovery ZMQ on 0.0.0.0:${PROXY_PING_PORT}"

python -m atom.kv_transfer.disaggregation.proxy --port ${PROXY_HTTP_PORT} \
  2>&1 | tee proxy.log
