#!/bin/bash

set -eu

YQ_VERSION="v4.6.1"
JB_VERSION="v0.4.0"


mkdir -p "${GITHUB_WORKSPACE}/bin"
cd "${GITHUB_WORKSPACE}/bin"

curl -sL "https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64" -o yq
chmod +x "${GITHUB_WORKSPACE}/bin/yq"

curl -sL "https://github.com/jsonnet-bundler/jsonnet-bundler/releases/download/${JB_VERSION}/jb-linux-amd64" -o jb
chmod +x "${GITHUB_WORKSPACE}/bin/jb"

echo "${GITHUB_WORKSPACE}/bin" >> "${GITHUB_PATH}"
echo "$RUNNER_WORKSPACE/$(basename "${GITHUB_REPOSITORY}")/bin" >> "${GITHUB_PATH}"
