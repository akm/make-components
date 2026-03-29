# ## go/mod.mk
# go mod tidy を実行し、go.mod / go.sum から不要な依存を整理する。
#
# ## Targets:
# - go-mod-tidy: go mod tidy を実行する

.PHONY: go-mod-tidy
go-mod-tidy:
	go mod tidy
