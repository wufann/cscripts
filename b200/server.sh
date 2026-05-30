export SGLANG_TORCH_PROFILER_DIR=/raid/home/fanwu103/mimo/profile
sglang serve \
  --trust-remote-code \
  --model-path /raid/models/MiMo-V2.5-Pro \
  --tp 8 \
  --moe-runner-backend flashinfer_trtllm \
  --attention-backend fa4 \
  --disable-radix-cache \
  --mem-fraction-static 0.8 \
  --max-running-requests 128 \
  --chunked-prefill-size 32768 \
  --swa-full-tokens-ratio 0.1 \
  --model-loader-extra-config '{"enable_multithread_load": true, "num_threads": 64}' \
  --reasoning-parser mimo \
  --tool-call-parser mimo \
  --host 0.0.0.0 \
  --port 30000
