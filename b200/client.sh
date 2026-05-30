CON="4"
COMBINATIONS=("8192/1")
for combo in "${COMBINATIONS[@]}"; do
   IFS="/" read -r isl osl <<< "$combo"
   for con in $CON; do
       prompts=$(($con))
       echo "[RUNNING] prompts $prompts isl $isl osl $osl con $con"
       python3 -m sglang.bench_serving \
       --backend sglang \
       --host 0.0.0.0 \
       --port 30000 \
       --dataset-name random \
       --random-range-ratio 1 \
       --num-prompt 640 \
       --random-input $isl \
       --random-output $osl \
       --warmup-requests $con \
       --max-concurrency $con
    done
done
