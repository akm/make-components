# ## golangci-lint/run.mk
# golangci-lint の install / uninstall / run を管理する。
# go/install.mk のユーティリティ関数を使い、バイナリが未インストールの場合は自動で install する。
# v1 / v2 の両方に対応しており、GOLANGCLI_LINT_VERSION_BASE で切り替え可能。
#
# ## Requires:
# - go/install.mk: go-install-bin-path, go-install-install, go-install-uninstall 関数を使用
#
# ## Variables (overridable):
# - GOLANGCLI_LINT_VERSION_BASE: メジャーバージョン系統 (default: v2)
# - GOLANGCLI_LINT_VERSION: インストールするバージョン (default: latest)
#
# ## Internal variables:
# - GOLANGCLI_LINT_MODULE: バージョン系統に対応するモジュールパス
# - GOLANGCLI_LINT_BIN: golangci-lint バイナリのフルパス
#
# ## Targets:
# - golangci-lint-run: lint を実行する（未インストール時は自動 install）
# - golangci-lint-install: golangci-lint をインストールする
# - golangci-lint-uninstall: golangci-lint をアンインストールする

GOLANGCLI_LINT_VERSION_BASE?=v2
GOLANGCLI_LINT_VERSION?=latest
GOLANGCLI_LINT_MODULE_v1=github.com/golangci/golangci-lint/cmd/golangci-lint
GOLANGCLI_LINT_MODULE_v2=github.com/golangci/golangci-lint/v2/cmd/golangci-lint
GOLANGCLI_LINT_MODULE=$(GOLANGCLI_LINT_MODULE_$(GOLANGCLI_LINT_VERSION_BASE))

GOLANGCLI_LINT_BIN=$(call go-install-bin-path,$(GOLANGCLI_LINT_MODULE))
$(GOLANGCLI_LINT_BIN):
	$(MAKE) golangci-lint-install

.PHONY: golangci-lint-run
golangci-lint-run: $(GOLANGCLI_LINT_BIN)
	$(GOLANGCLI_LINT_BIN) run ./...

.PHONY: golangci-lint-install
golangci-lint-install:
	$(call go-install-install,$(GOLANGCLI_LINT_MODULE),$(GOLANGCLI_LINT_VERSION))

.PHONY: golangci-lint-uninstall
golangci-lint-uninstall:
	$(call go-install-uninstall,$(GOLANGCLI_LINT_BIN))
