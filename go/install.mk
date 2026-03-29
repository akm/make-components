# ## go/install.mk
# Go ツールバイナリの install / uninstall を管理するユーティリティ。
# GOBIN または GOPATH/bin を自動検出し、モジュールパスからバイナリパスの解決・インストール・アンインストールを行う。
# golangci-lint 等の外部ツール管理用 .mk から呼び出されることを想定している。
#
# ## Requires:
# - PATH_TO_MAKE_COMPONENTS: make-components ディレクトリへのパス
#
# ## Public variables:
# - GO_INSTALL_PATH_TO_BIN: ツールバイナリのインストール先ディレクトリ (GOBIN または GOPATH/bin)
# - GO_INSTALL_GOBIN: go env GOBIN の値（設定されている場合）
# - GO_INSTALL_GOPATH: go env GOPATH の値（GOBIN 未設定時のフォールバックに使用）
#
# ## Public functions (call で使用):
# - go-install-bin-path(MODULE): モジュールパスからバイナリのフルパスを返す
# - go-install-install(MODULE, VERSION): 指定バージョンのモジュールを go install する
# - go-install-uninstall(BIN_PATH): 指定パスのバイナリを削除する

GO_INSTALL_GOBIN=$(shell go env GOBIN)
GO_INSTALL_GOPATH=$(shell go env GOPATH)
ifneq ($(GO_INSTALL_GOBIN),)
GO_INSTALL_PATH_TO_BIN=$(GO_INSTALL_GOBIN)
else
GO_INSTALL_PATH_TO_BIN=$(GO_INSTALL_GOPATH)/bin
endif

# arguments:
# $(1): golang module name
#
# example:
# $(call go-install-bin-path,github.com/golangci/golangci-lint/v2/cmd/golangci-lint)
define go-install-bin-path
$(GO_INSTALL_PATH_TO_BIN)/$(notdir $(1))
endef

# arguments:
# $(1): MODULE
# $(2): MODULE_VERSION
#
# example:
# $(call go-install-install,github.com/golangci/golangci-lint/v2/cmd/golangci-lint,v2.11.4)
define go-install-install
	go install $(1)@$(2)
endef

# arguments:
# $(1): MODULE_BIN_PATH
define go-install-uninstall
	rm -f $(1)
endef
