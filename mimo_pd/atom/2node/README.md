# MiMo-V2-Flash 1P1D PD disaggregation, 2 nodes, Mooncake

## Layout
- **Node A (prefill)**: runs `proxy` + `prefill` server. TP4 on GPU 0-3.
- **Node B (decode)**: runs `decode` server. TP4 on GPU 0-3.

## Setup

1. Edit `env.sh` on **both nodes**:
   - `PREFILL_IP` — IP of node A
   - `DECODE_IP` — IP of node B
   - `NCCL_SOCKET_IFNAME` — actual NIC name (not `lo` for multi-node!)
   - `MODEL` — local model path on each node

2. Confirm RDMA visible inside containers on both nodes:
   ```bash
   ibv_devices
   ls /dev/infiniband/
   ```

3. Mooncake must be installed on both nodes with the **same build commit**
   (`Corrupted segment descriptor` otherwise). See `../install_mooncake.sh`.

## Run order

**Node A:**
```bash
bash run_proxy.sh         # terminal 1
bash run_prefill.sh       # terminal 2 (wait for proxy)
```

**Node B:**
```bash
bash run_decode.sh        # wait for prefill to finish model warmup
```

**Anywhere reachable to Node A:**
```bash
bash test_request.sh
```

## Verify registration

In `proxy.log` you should see:
```
Registering new instance: ... role=P ... request_address=http://<PREFILL_IP>:8003/v1/completions
Registering new instance: ... role=D ... request_address=http://<DECODE_IP>:8004/v1/completions
```

Both lines must appear before sending a request.
