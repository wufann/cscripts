#!/bin/bash
# Decode 节点 (kv_consumer) — MiMo-V2-Flash TP4, GPU 4-7
set -e

MODEL=${MODEL:-/it-share/models/MiMo-V2-Flash}
#LOCAL_IP=${LOCAL_IP:-$(ip addr show | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}' | cut -d/ -f1 | head -1)}
export LOCAL_IP=$(hostname -I | awk '{print $1}')
PROXY_IP=${PROXY_IP:-${LOCAL_IP}}
PROXY_PING_PORT=${PROXY_PING_PORT:-36367}
HTTP_PORT=${HTTP_PORT:-8004}

echo "Local IP : ${LOCAL_IP}"
echo "Proxy IP : ${PROXY_IP}:${PROXY_PING_PORT}"
echo "HTTP port: ${HTTP_PORT}"

export HIP_VISIBLE_DEVICES=4,5,6,7
export ATOM_DISABLE_MMAP=true
export NCCL_SOCKET_IFNAME=lo
export AITER_LOG_LEVEL=WARNING

python -m atom.entrypoints.openai_server \
  --model ${MODEL} \
  --kv_cache_dtype fp8 \
  -tp 4 \
  --trust-remote-code \
  --server-port ${HTTP_PORT} \
  --kv-transfer-config '{
    "kv_role": "kv_consumer",
    "kv_connector": "mooncake",
    "proxy_ip": "'"${PROXY_IP}"'",
    "proxy_ping_port": '"${PROXY_PING_PORT}"',
    "http_port": '"${HTTP_PORT}"'
  }'
