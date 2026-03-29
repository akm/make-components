# ## go/goarch.mk
# 現在の Go ランタイムのアーキテクチャ (GOARCH) を検出する。
# goarch.go を実行して runtime.GOARCH の値を取得し、クロスコンパイル等で使用する。
#
# ## Requires:
# - PATH_TO_MAKE_COMPONENTS: make-components ディレクトリへのパス
#
# ## Public variables:
# - GO_BUILD_GOARCH: 検出されたアーキテクチャ (例: amd64, arm64)
#
# ## Targets:
# - go-build-goarch: GO_BUILD_GOARCH の値を標準出力に表示する

GO_BUILD_GOARCH?=$(shell go run $(PATH_TO_MAKE_COMPONENTS)/go/goarch.go)

.PHONY: go-build-goarch
go-build-goarch:
	@echo "$(GO_BUILD_GOARCH)"
