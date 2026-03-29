# ## go/test.mk
# Go の全パッケージに対してテストを実行する。
# GO_TEST_OPTS で -v, -race, -count=1 等のオプションを追加できる。
#
# ## Variables (overridable):
# - GO_TEST_OPTS: go test に渡す追加オプション (default: 空)
#
# ## Targets:
# - go-test-all: ./... 配下の全パッケージのテストを実行する

GO_TEST_OPTS?=

.PHONY: go-test-all
go-test-all:
	go test $(GO_TEST_OPTS) ./...
