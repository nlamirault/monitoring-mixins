# Copyright (C) 2021 Nicolas Lamirault <nicolas.lamirault@gmail.com>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# ================================================================
# JSONNET

# FROM alpine:3.13 AS jsonnet-builder
# RUN apk add --no-cache git make g++
# RUN git clone https://github.com/google/jsonnet && \
#     git  -C jsonnet checkout v0.17.0 && \
#     make -C jsonnet 2LDFLAGS=-static && \
#     cp jsonnet/jsonnet /usr/bin && \
#     cp jsonnet/jsonnetfmt /usr/bin

# ================================================================
# Jb

# FROM alpine:3.13 AS jb-builder
# ARG JSONNET_BUNDLER_VERSION=0.4.0
# ARG JSONNET_BUNDLER_CHECKSUM="433edab5554a88a0371e11e93080408b225d41c31decf321c02b50d2e44993ce  /usr/bin/jb"
# RUN apk add --no-cache curl
# RUN curl -fSL -o "/usr/bin/jb" "https://github.com/jsonnet-bundler/jsonnet-bundler/releases/download/v${JSONNET_BUNDLER_VERSION}/jb-linux-amd64"
# RUN echo "${JSONNET_BUNDLER_CHECKSUM}" | sha256sum -c || (printf "wanted: %s\n   got: %s\n" "${JSONNET_BUNDLER_CHECKSUM}" "$(sha256sum /usr/bin/jb)"; exit 1)
# RUN chmod +x /usr/bin/jb

# ================================================================
# Mixtool

FROM golang:1.17 AS mixtool-builder

WORKDIR /go/src/app

# RUN GO111MODULE=on go get -u github.com/monitoring-mixins/mixtool/cmd/mixtool
RUN go install github.com/monitoring-mixins/mixtool/cmd/mixtool@latest

# ================================================================
# Github Action

FROM alpine:3.15

LABEL maintainer="Nicolas Lamirault <nicolas.lamirault@gmail.com>" \
    org.opencontainers.image.title="A GitHub Action for monitoring-mixins" \
    org.opencontainers.image.description="A GitHub Action for monitoring-mixins" \
    org.opencontainers.image.authors="Nicolas Lamirault <nicolas.lamirault@gmail.com>" \
    org.opencontainers.image.vendor="nlamirault" \
    org.opencontainers.image.documentation="https://github.com/nlamirault/monitoring-mixins" \
    org.opencontainers.image.licenses="Apache 2.0" \
    org.opencontainers.image.url="https://github.com/nlamirault/monitoring-mixins" \
    org.opencontainers.image.source="https://github.com/nlamirault/monitoring-mixins" \
    org.opencontainers.image.version="0.1.0"

RUN apk add --no-cache ca-certificates curl bash tar make jq

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# COPY --from=jsonnet-builder /usr/bin/jsonnetfmt /usr/bin
# COPY --from=jsonnet-builder /usr/bin/jsonnet /usr/bin
# COPY --from=jb-builder /usr/bin/jb /usr/bin
COPY --from=mixtool-builder /go/bin/mixtool /usr/bin

ENTRYPOINT ["/entrypoint.sh"]
