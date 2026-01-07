#!/usr/bin/env bash
set -eux -o pipefail


if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" == "1" ]]; then
  if [[ "${target_platform}" == linux-* ]]; then
    # Get an updated config.sub and config.guess
    # (see https://conda-forge.org/docs/maintainer/knowledge_base.html#cross-compilation)
    pushd "${BUILD_PREFIX}/share/gnuconfig"
      cp config.* "${SRC_DIR}"
    popd
  fi
fi

./configure --prefix "${PREFIX}"

make
make check
make install
make installcheck
