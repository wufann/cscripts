#!/bin/bash
PROXY_PORT=${PROXY_PORT:-30001}

curl -s http://localhost:${PROXY_PORT}/v1/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "/it-share/models/MiMo-V2-Flash",
    "prompt": "Explain PD disaggregation in one sentence.",
    "max_tokens": 64,
    "stream": false
  }'
  #}' | python -m json.tool
