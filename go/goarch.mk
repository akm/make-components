GO_BUILD_GOARCH?=$(shell go run $(PATH_TO_MAKE_COMPONENTS)/go/goarch.go)

.PHONY: go-build-goarch
go-build-goarch:
	@echo "$(GO_BUILD_GOARCH)"
