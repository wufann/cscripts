# python3 csrc/ck_gemm_a8w8_blockscale/gemm_a8w8_blockscale_tune.py \
#      -i aiter/configs/a8w8_blockscale_untuned_gemm.csv \
#      -o aiter/configs/a8w8_blockscale_tuned_gemm.csv \
#      --libtype both
#
#
#  python3 csrc/ck_gemm_a8w8_blockscale/gemm_a8w8_blockscale_tune.py \
#      --preshuffle \
#      -k \
#      -i aiter/configs/a8w8_blockscale_bpreshuffle_untuned_gemm.csv \
#      -o aiter/configs/a8w8_blockscale_bpreshuffle_tuned_gemm.csv



python3 csrc/ck_gemm_a8w8_blockscale/gemm_a8w8_blockscale_tune.py \
    --preshuffle \
    -i aiter/configs/model_configs/a8w8_blockscale_bpreshuffle_untuned_gemm_mimo_v2_5_pro.csv \
    -o aiter/configs/model_configs/a8w8_blockscale_bpreshuffle_tuned_gemm_mimo_v2_5_pro.csv \
    -k
