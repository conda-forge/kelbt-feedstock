#!/usr/bin/env bash
set -eux -o pipefail

if [[ "${host_platform}" == "linux-aarch64" || "${host_platform}" == "linux-ppc64le" ]]; then
  cp "${BUILD_PREFIX}/share/gnuconfig"/config.* .
fi

./configure --prefix "${PREFIX}"

make
make install

# Skip ``make check`` when cross-compiling
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR:-}" != "" ]]; then
  make check
  make installcheck
fi
