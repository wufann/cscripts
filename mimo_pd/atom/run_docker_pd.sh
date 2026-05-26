bash ci_run.sh --name fanwu103-atom-mimo-pd \
	-it \
	--shm-size 64g \
	-v /mnt/:/mnt/ \
        -v /data/:/data/ \
        -v /it-share/:/it-share/ \
        -v /home/:/home/ \
        rocm/atom-dev:vllm-v0.19.0-nightly_20260517-mooncake-dev-latest \
        /bin/bash

