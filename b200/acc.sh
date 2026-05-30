python3 -m sglang.test.run_eval \
  --base-url http://127.0.0.1:30000 \
  --model /raid/models/MiMo-V2.5-Pro \
  --eval-name gsm8k \
  --num-examples 200 \
  --num-threads 8 \
  --max-tokens 4096 \
  --temperature 0.0
