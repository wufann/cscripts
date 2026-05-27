#!/bin/bash
# Shared config — source this from each script, or edit values before each run.
# Both nodes must agree on PREFILL_IP / PROXY_IP / PROXY_PING_PORT.

# === EDIT THESE TO MATCH YOUR TWO NODES ===
export PREFILL_IP=${PREFILL_IP:-10.24.112.181}   # IP of the prefill node (also runs the proxy)
export DECODE_IP=${DECODE_IP:-10.24.112.182}     # IP of the decode node

# === Proxy / discovery ===
export PROXY_IP=${PROXY_IP:-${PREFILL_IP}}       # proxy runs on prefill node by default
export PROXY_HTTP_PORT=${PROXY_HTTP_PORT:-30001} # client → proxy HTTP
export PROXY_PING_PORT=${PROXY_PING_PORT:-36367} # ZMQ discovery (proxy.py hardcoded)

# === Per-node OpenAI server ports ===
export PREFILL_HTTP_PORT=${PREFILL_HTTP_PORT:-8003}
export DECODE_HTTP_PORT=${DECODE_HTTP_PORT:-8004}

# === Model ===
export MODEL=${MODEL:-/it-share/models/MiMo-V2-Flash}

# === RDMA / network interface on each node ===
# NCCL_SOCKET_IFNAME: actual NIC used for control-plane (NOT lo on multi-node!)
export NCCL_SOCKET_IFNAME=${NCCL_SOCKET_IFNAME:-bond0}
# ATOM_HOST_IP overrides auto-detected RDMA IP; set if Mooncake picks the wrong NIC
# export ATOM_HOST_IP=...

export ATOM_DISABLE_MMAP=true
export AITER_LOG_LEVEL=WARNING
