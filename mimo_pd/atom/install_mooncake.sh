#!/bin/bash
# Install Mooncake (ROCm build) for ATOM PD disaggregation.
# Based on recipes/pd_disaggregation_guide.md (SGLang-validated commit).
#
# Usage: bash install_mooncake.sh [WORKDIR]
#   WORKDIR defaults to $HOME/mooncake_build
#
# Run inside the rocm/atom container. Re-runnable; skips finished steps.

set -euo pipefail

WORKDIR=${1:-$HOME/mooncake_build}
GO_VERSION=1.22.2
MOONCAKE_COMMIT=b6a841dc78c707ec655a563453277d969fb8f38d

mkdir -p "${WORKDIR}"
cd "${WORKDIR}"

echo "===== [1/5] System dependencies ====="
apt update
apt install -y \
    zip unzip wget gcc make libtool autoconf cmake \
    librdmacm-dev rdmacm-utils infiniband-diags ibverbs-utils perftest ethtool \
    libibverbs-dev rdma-core \
    openssh-server openmpi-bin openmpi-common libopenmpi-dev \
    libgoogle-glog-dev

install_go() {
    # Mooncake's etcd wrapper needs exactly 1.22.x; 1.23+ breaks with `mallocHeaderSize redeclared`.
    apt remove -y golang golang-go 2>/dev/null || true
    rm -rf /usr/local/go
    wget -q https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz -O /tmp/go.tar.gz
    tar -C /usr/local -xzf /tmp/go.tar.gz
    rm /tmp/go.tar.gz
    export PATH=/usr/local/go/bin:$PATH
    hash -r
    go version
}

echo "===== [2/5] Go ${GO_VERSION} ====="
install_go

echo "===== [3/5] Clone + build Mooncake ====="
if [ ! -d Mooncake ]; then
    git clone https://github.com/kvcache-ai/Mooncake.git
fi
cd Mooncake
git fetch --all
git checkout ${MOONCAKE_COMMIT}
git submodule update --init --recursive

bash dependencies.sh -y

# dependencies.sh force-upgrades Go to 1.23.x — re-pin to 1.22.2 before building etcd_wrapper.
echo "===== Re-pinning Go to ${GO_VERSION} (dependencies.sh upgraded it) ====="
install_go

mkdir -p build
cd build
cmake .. -DUSE_HIP=ON -DUSE_ETCD=ON
make -j"$(nproc)"
make install
cd ..

echo "===== [4/5] Install Python package + copy .so ====="
cd mooncake-wheel
pip install .
MOONCAKE_DIR=$(python -c "import mooncake; print(mooncake.__path__[0])")
cp ../build/mooncake-integration/engine.cpython-*-linux-gnu.so "${MOONCAKE_DIR}/"
ldconfig

echo "===== [5/5] Verify ====="
python -c "from mooncake.engine import TransferEngine; print('Mooncake ROCm OK')"

echo ""
echo "Done. To switch ATOM PD from MoRIIO to Mooncake, set kv_connector=mooncake"
echo "in the --kv-transfer-config JSON of producer and consumer."
