# ## go/build.mk
# Go パッケージ全体をビルドする。コンパイルエラーの検出に使用する。
#
# ## Targets:
# - go-build-all: ./... 配下の全パッケージをビルド

.PHONY: go-build-all
go-build-all:
	go build ./...
