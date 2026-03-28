GO_TEST_OPTS?=

.PHONY: go-test-all
go-test-all:
	go test $(GO_TEST_OPTS) ./...
