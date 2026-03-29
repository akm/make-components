# ## go/get.mk
# Go モジュールの依存関係を更新する。
# 引数なしで全依存を一括更新、GO_MOD_NAME 指定で特定モジュールのみ更新できる。
#
# ## Variables (optional):
# - GO_MOD_NAME: 更新対象のモジュール名。未指定時は全依存を更新 (go get -u ./...)
# - GO_MOD_VERSION: 更新先のバージョン。GO_MOD_NAME と併用する (例: v1.2.3)
#
# ## Targets:
# - go-get-update: 依存関係を更新する

.PHONY: go-get-update
go-get-update:
ifndef GO_MOD_NAME
	go get -u ./...
else ifndef GO_MOD_VERSION
	go get -u ${GO_MOD_NAME}
else
	go get -u ${GO_MOD_NAME}@${GO_MOD_VERSION}
endif
