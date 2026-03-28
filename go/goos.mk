GO_BUILD_GOOS?=$(shell go run $(PATH_TO_MAKE_COMPONENTS)/go/goos.go)

.PHONY: go-build-goos
go-build-goos:
	@echo "$(GO_BUILD_GOOS)"
