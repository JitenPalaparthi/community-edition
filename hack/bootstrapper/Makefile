all: build
.PHONY: all

build: build-kcp build-cert-mgr build-capi
.PHONY: build

build-kcp:
	./build-kcp.sh

build-cert-mgr:
	./build-cert-mgr.sh

build-capi:
	./build-capi.sh

gen-crds:
	./gen-crds.sh
.PHONY: gen-crds

vendor:
	go mod tidy
	go mod vendor
.PHONY: vendor

codegen:
	./hack/update-codegen.sh
.PHONY: codegen
