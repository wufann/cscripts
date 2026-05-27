#!/bin/bash
# Run on the PREFILL node (same node as proxy). TP4 on GPU 0-3.
set -e
source "$(dirname "$0")/env.sh"


echo "Prefill on ${PREFILL_IP}:${PREFILL_HTTP_PORT}"
echo "→ proxy ${PROXY_IP}:${PROXY_PING_PORT}"

python -m atom.entrypoints.openai_server \
  --model ${MODEL} \
  --kv_cache_dtype fp8 \
  -tp 8 \
  --trust-remote-code \
  --server-port ${PREFILL_HTTP_PORT} \
  --kv-transfer-config '{
    "kv_role": "kv_producer",
    "kv_connector": "mooncake",
    "proxy_ip": "'"${PROXY_IP}"'",
    "proxy_ping_port": '"${PROXY_PING_PORT}"',
    "http_port": '"${PREFILL_HTTP_PORT}"'
  }' \
  2>&1 | tee prefill.log
