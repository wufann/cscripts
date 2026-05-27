#!/bin/bash
# Run on the DECODE node. TP4 on GPU 0-3.
# Make sure env.sh has the correct PREFILL_IP (where proxy is reachable).
set -e
source "$(dirname "$0")/env.sh"

export HIP_VISIBLE_DEVICES=0,1,2,3

echo "Decode on ${DECODE_IP}:${DECODE_HTTP_PORT}"
echo "→ proxy ${PROXY_IP}:${PROXY_PING_PORT}"

python -m atom.entrypoints.openai_server \
  --model ${MODEL} \
  --kv_cache_dtype fp8 \
  -tp 4 \
  --trust-remote-code \
  --server-port ${DECODE_HTTP_PORT} \
  --kv-transfer-config '{
    "kv_role": "kv_consumer",
    "kv_connector": "mooncake",
    "proxy_ip": "'"${PROXY_IP}"'",
    "proxy_ping_port": '"${PROXY_PING_PORT}"',
    "http_port": '"${DECODE_HTTP_PORT}"'
  }' \
  2>&1 | tee decode.log
