python -m atom.benchmarks.benchmark_serving \
  --model=/it-share/models/MiMo-V2.5-Pro --backend=vllm --base-url=http://localhost:30001 \
  --dataset-name=random \
  --random-input-len=16384 --random-output-len=1024 \
  --random-range-ratio=1 \
  --num-prompts=640 --max-concurrency=64 \
  --request-rate=inf --ignore-eos \
  --save-result --percentile-metrics="ttft,tpot,itl,e2el"

python -m atom.benchmarks.benchmark_serving \
  --model=/it-share/models/MiMo-V2.5-Pro --backend=vllm --base-url=http://localhost:30001 \
  --dataset-name=random \
  --random-input-len=16384 --random-output-len=1024 \
  --random-range-ratio=1 \
  --num-prompts=960 --max-concurrency=96 \
  --request-rate=inf --ignore-eos \
  --save-result --percentile-metrics="ttft,tpot,itl,e2el"
