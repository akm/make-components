# Requires:
# - make-components/go/install.mk

GOLANGCLI_LINT_VERSION_BASE?=v2
GOLANGCLI_LINT_VERSION?=latest
GOLANGCLI_LINT_MODULE_v1=github.com/golangci/golangci-lint/cmd/golangci-lint
GOLANGCLI_LINT_MODULE_v2=github.com/golangci/golangci-lint/v2/cmd/golangci-lint
GOLANGCLI_LINT_MODULE=$(GOLANGCLI_LINT_MODULE_$(GOLANGCLI_LINT_VERSION_BASE))

GOLANGCLI_LINT_BIN=$(call go-install-bin-path,$(GOLANGCLI_LINT_MODULE))
$(GOLANGCLI_LINT_BIN):
	$(MAKE) golangci-lint-install

.PHONY: golangci-lint-run
golangci-lint-run: $(GOLANGCLI_LINT_BIN)
	$(GOLANGCLI_LINT_BIN) run ./...

.PHONY: golangci-lint-install
golangci-lint-install:
	$(call go-install-install,$(GOLANGCLI_LINT_MODULE),$(GOLANGCLI_LINT_VERSION))

.PHONY: golangci-lint-uninstall
golangci-lint-uninstall:
	$(call go-install-uninstall,$(GOLANGCLI_LINT_BIN))
