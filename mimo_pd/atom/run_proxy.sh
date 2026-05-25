#!/bin/bash
set -e

PROXY_PORT=${PROXY_PORT:-30001}

python -m atom.kv_transfer.disaggregation.proxy --port ${PROXY_PORT}
