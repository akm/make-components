# ## Requires:
# - PATH_TO_MAKE_COMPONENTS: path to the directory where the make-components are located, used to call the go install makefile

# ## public variables
# GO_INSTALL_PATH_TO_BIN: path to the directory where the golang tool binaries are installed
#
# GO_INSTALL_GOBIN: path to the directory where the golang tool binaries are installed, if set
# GO_INSTALL_GOPATH: path to the GOPATH, used to determine the default installation path for golang tool binaries when GO_INSTALL_GOBIN is not set

GO_INSTALL_GOBIN=$(shell go env GOBIN)
GO_INSTALL_GOPATH=$(shell go env GOPATH)
ifneq ($(GO_INSTALL_GOBIN),)
GO_INSTALL_PATH_TO_BIN=$(GO_INSTALL_GOBIN)
else
GO_INSTALL_PATH_TO_BIN=$(GO_INSTALL_GOPATH)/bin
endif

# arguments:
# $(1): golang module name
#
# example:
# $(call go-install-bin-path,github.com/golangci/golangci-lint/v2/cmd/golangci-lint)
define go-install-bin-path
$(GO_INSTALL_PATH_TO_BIN)/$(notdir $(1))
endef

# arguments:
# $(1): MODULE
# $(2): MODULE_VERSION
#
# example:
# $(call go-install-install,github.com/golangci/golangci-lint/v2/cmd/golangci-lint,v2.11.4)
define go-install-install
	go install $(1)@$(2)
endef

# arguments:
# $(1): MODULE_BIN_PATH
define go-install-uninstall
	rm -f $(1)
endef
