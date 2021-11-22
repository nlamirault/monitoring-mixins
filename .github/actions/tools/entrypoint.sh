#!/bin/bash

set -eu

YQ_VERSION="v4.9.3"
JB_VERSION="v0.4.0"
JSONNET_VERSION="0.17.0"

mkdir -p "${GITHUB_WORKSPACE}/bin"
cd "${GITHUB_WORKSPACE}/bin"

curl -sL "https://github.com/mikefarah/yq/releases/download/${YQ_VERSION}/yq_linux_amd64" -o yq
chmod +x "${GITHUB_WORKSPACE}/bin/yq"

curl -sL "https://github.com/jsonnet-bundler/jsonnet-bundler/releases/download/${JB_VERSION}/jb-linux-amd64" -o jb
chmod +x "${GITHUB_WORKSPACE}/bin/jb"

curl -sL "https://github.com/google/go-jsonnet/releases/download/v${JSONNET_VERSION}/go-jsonnet_${JSONNET_VERSION}_Linux_x86_64.tar.gz" | \
tar xz
chmod +x "${GITHUB_WORKSPACE}/bin/jsonnet"
chmod +x "${GITHUB_WORKSPACE}/bin/jsonnetfmt"

go install github.com/monitoring-mixins/mixtool/cmd/mixtool@latest
cp "${HOME}/go/bin/mixtool" "${GITHUB_WORKSPACE}/bin/mixtool"

echo "${GITHUB_WORKSPACE}/bin" >> ${GITHUB_PATH}
echo "$RUNNER_WORKSPACE/$(basename "${GITHUB_REPOSITORY}")/bin" >> ${GITHUB_PATH}

# DEBUG
ls -alFrt "${GITHUB_WORKSPACE}/bin/"
