.PHONY: go-get-update
go-get-update:
ifndef GO_MOD_NAME
	go get -u ./...
else ifndef GO_MOD_VERSION
	go get -u ${GO_MOD_NAME}
else
	go get -u ${GO_MOD_NAME}@${GO_MOD_VERSION}
endif
