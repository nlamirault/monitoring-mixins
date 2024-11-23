#!/bin/bash

set -eu

[ -z "${VERSION}" ] && echo_fail "Version not satisfied" && exit 1
make mixins APP=monitoring-mixins VERSION="${VERSION}"
