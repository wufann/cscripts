lm_eval --model local-completions \
  --model_args model=/it-share/models/MiMo-V2-Flash,base_url=http://localhost:30001/v1/completions,num_concurrent=64,max_retries=3,tokenized_requests=False \
  --tasks gsm8k --num_fewshot 5
