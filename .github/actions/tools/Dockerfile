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

ENTRYPOINT ["/entrypoint.sh"]
