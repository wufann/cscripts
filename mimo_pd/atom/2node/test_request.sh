#!/bin/bash
# Run from anywhere that can reach the prefill node's proxy port.
set -e
source "$(dirname "$0")/env.sh"

curl -s http://${PROXY_IP}:${PROXY_HTTP_PORT}/v1/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "'"${MODEL}"'",
    "prompt": "Explain prefill-decode disaggregation in one sentence.",
    "max_tokens": 64,
    "stream": false
  }' | python -m json.tool
