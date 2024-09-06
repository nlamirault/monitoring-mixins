# Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
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
#
# SPDX-License-Identifier: Apache-2.0

BANNER = M O N I T O R I N G  /  M I X I N S

DEBUG ?=

SHELL = /bin/bash -o pipefail

PYTHON_VENV = .venv

DIR = $(shell pwd)

NO_COLOR=\033[0m
OK_COLOR=\033[32;01m
ERROR_COLOR=\033[31;01m
WARN_COLOR=\033[33;01m
INFO_COLOR=\033[34;01m
WHITE_COLOR=\033[1m

MAKE_COLOR=\033[33;01m%-20s\033[0m

.DEFAULT_GOAL := help

OK=[✅]
KO=[❌]
WARN=[⚠️]

.PHONY: help
help:
	@echo -e "$(OK_COLOR)        $(BANNER)$(NO_COLOR)"
	@echo "------------------------------------------------------------------"
	@echo ""
	@awk 'BEGIN {FS = ":.*##"; printf "${ERROR_COLOR}Usage${NO_COLOR}: make ${INFO_COLOR}<target>${NO_COLOR}\n"} /^[a-zA-Z_-]+:.*?##/ { printf "  ${INFO_COLOR}%-25s${NO_COLOR} %s\n", $$1, $$2 } /^##@/ { printf "\n${WHITE_COLOR}%s${NO_COLOR}\n", substr($$0, 5) } ' $(MAKEFILE_LIST)
	@echo ""

guard-%:
	@if [ "${${*}}" = "" ]; then \
		echo -e "$(ERROR_COLOR)Environment variable $* not set$(NO_COLOR)"; \
		exit 1; \
	fi

check-%:
	@if $$(hash $* 2> /dev/null); then \
		echo -e "$(OK_COLOR)$(OK)$(NO_COLOR) $*"; \
	else \
		echo -e "$(ERROR_COLOR)$(KO)$(NO_COLOR) $*"; \
	fi

##@ Development

.PHONY: check
check: check-git check-jsonnet check-jb check-jq check-yq check-promtool check-promdoc check-jsonnetfmt ## Check requirements

.PHONY: clean
clean: ## Clean environment
	rm -fr monitoring-mixins
	find . -name "*.lock.json" | xargs rm -fr {} \;

.PHONY: init
init: ## Initialize environment
	uv venv
	uv pip install
	# pre-commit install

.PHONY: fmt
fmt: ## Format Python
	uv tool run ruff linter

.PHONY: test
test: guard-SERVICE ## Test rules (SERVICE=xxx)
	promtool check rules $(SERVICE)/prometheus/*.yaml

.PHONY: validate
validate: ## Execute git-hooks
	@pre-commit run -a

.PHONY: deps
deps: ## Install dependencies
	go install github.com/google/go-jsonnet/cmd/jsonnet@v0.18.0
	go install github.com/google/go-jsonnet/cmd/jsonnetfmt@v0.18.0
	go install github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb@v0.4.0
	go install github.com/brancz/gojsontoyaml@latest
	go install github.com/monitoring-mixins/mixtool/cmd/mixtool@latest
	go install github.com/grafana/dashboard-linter@latest


# ====================================
# M I X I N S
# ====================================

##@ Mixins

.PHONY: dashboards
dashboards: guard-MIXIN guard-VERSION ## Download dashboards
	@. $(PYTHON_VENV)/bin/activate \
		&& ./hack/dashboards.py $(MIXIN) --log debug

.PHONY: all-dashboards
all-dashboards: ## Download all dashboards
	@. $(PYTHON_VENV)/bin/activate \
		&& ./hack/dashboards.py osm-mixin \
		&& ./hack/dashboards.py fluxcd-mixin \
		&& ./hack/dashboards.py linkerd-stable-mixin \
		&& ./hack/dashboards.py linkerd-edge-mixin \
		&& ./hack/dashboards.py nginx-ingress-controller-mixin

.PHONY: mixin
mixin: guard-MIXIN guard-APP guard-VERSION ## Build a mixin
	@./hack/mixins.sh monitoring-mixins $(APP) $(VERSION) $(MIXIN)

.PHONY: mixins
mixins: guard-APP guard-VERSION ## Build mixins
	@./hack/mixins.sh monitoring-mixins $(APP) $(VERSION)

.PHONY: dist
dist: guard-VERSION ## Create an archive
	@zip -r monitoring-mixins-v$(VERSION).zip monitoring-mixins

.PHONY: dist-tenant
dist-tenant: guard-APP guard-VERSION ## Create an archive
	@zip -r monitoring-mixins-$(APP)-v$(VERSION).zip monitoring-mixins

.PHONY: release
release: guard-VERSION ## Create a new release
	make mixins APP=monitoring-mixins VERSION=$(VERSION)
	make dist VERSION=$(VERSION)
