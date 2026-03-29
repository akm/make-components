# ## go/module.mk
# go.mod からモジュール名を抽出して変数に格納する。
# Docker イメージタグやバイナリ名の生成など、モジュール名を参照する場面で使用する。
#
# ## Public variables:
# - GO_MODULE_NAME: go.mod の module 行から抽出されたモジュール名 (例: github.com/akm/uchimark)

GO_MODULE_NAME:=$(shell sed -n 's/^module //p' go.mod)
