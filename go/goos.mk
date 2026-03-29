# ## go/goos.mk
# 現在の Go ランタイムの OS (GOOS) を検出する。
# goos.go を実行して runtime.GOOS の値を取得し、クロスコンパイル等で使用する。
#
# ## Requires:
# - PATH_TO_MAKE_COMPONENTS: make-components ディレクトリへのパス
#
# ## Public variables:
# - GO_BUILD_GOOS: 検出された OS 名 (例: linux, darwin)
#
# ## Targets:
# - go-build-goos: GO_BUILD_GOOS の値を標準出力に表示する

GO_BUILD_GOOS?=$(shell go run $(PATH_TO_MAKE_COMPONENTS)/go/goos.go)

.PHONY: go-build-goos
go-build-goos:
	@echo "$(GO_BUILD_GOOS)"
