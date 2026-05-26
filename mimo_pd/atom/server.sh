HIP_VISIBLE_DEVICES=4,5,6,7 python -m atom.entrypoints.openai_server --model /it-share/models/MiMo-V2-Flash -tp 4 --trust-remote-code --kv_cache_dtype fp8 --method mtp
